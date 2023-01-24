# We enable the new python 3 print syntax
from __future__ import print_function
import sys
import os
import re
import shutil
import xml.etree.ElementTree as ET
import json

project = e_projects.open_project(os.path.join(sys.argv[1], 'ecp', "src.ecp"))


def tryPrintObjectName(text, obj):
    try:
        print(text, obj.get_name())
    except:
        print(text, 'root')


def getTypeSafe(object):
    if hasattr(object, 'type'):
        return str(object.type)
    else:
        return 'root'


def fileContent(path):
    f = open(path, 'r')
    data = f.read()
    f.close()
    return data


def writeDataToFile(data, path):
    f = open(path, 'w')
    f.write(data)
    f.close()


def xMLListToPythList(element):
    list = []
    for child in element:
        list.append(child.text)
    return list


def textExportDeclImpl(object, path):
    f = open(path + '.st', 'w')
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text)
    f.write('\n(*%!%__DELIMITER__%!%*)\n')
    if object.has_textual_implementation:
        f.write(object.textual_implementation.text)
    f.close()


def textExportDecl(object, path):
    f = open(path + '.st', 'w')
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text)
    f.close()


def textExportImpl(object, path):
    f = open(path + '.st', 'w')
    if object.has_textual_implementation:
        f.write(object.textual_implementation.text)
    f.close()


def loopObjects(object, path):
    children = object.get_children(False)
    if len(children) > 0:
        if not os.path.exists(path):
            os.makedirs(path)
        for child in children:
            handleObject(child, path)


def handleFolder(object, path):
    newPath = os.path.join(path, "%F%" + object.get_name())
    os.makedirs(newPath)
    loopObjects(object, newPath)


def handleTextType(object, path, designator):
    path = os.path.join(path, designator + object.get_name())
    print('handleTextType->path', path)
    if designator == '%POU%':
        textExportDeclImpl(object, path)
    elif designator == '%METH%':
        textExportDeclImpl(object, path)
    elif designator == '%GETSET%':
        textExportDeclImpl(object, path)
    elif designator == '%TRAN%':
        textExportImpl(object, path)
    else:
        textExportDecl(object, path)
    loopObjects(object, path)


def handleTaskConfiguration(object, path):
    path = os.path.join(path, "%TC%" + object.get_name())
    print('handleTaskConfiguration->path', path)
    loopObjects(object, path)


def handleExternalFile(object, path):
    path = os.path.join(path, "%EF%" + object.get_name())
    print('handleExternalFile->path', path)
    object.export_native(path + '.xml', False)
    search = re.search(r"<Single Name=\"FileId\" Type=\"string\">00000000-0000-0000-0000-000000000000\|(.+)<\/Single>", fileContent(path + '.xml'))
    writeDataToFile(search.group(1), path + '.txt')
    os.remove(path + '.xml')


def handleTextList(object, path, isGlobal):
    if isGlobal:
        path = os.path.join(path, "%GTL%" + object.get_name())
    else:
        path = os.path.join(path, "%TL%" + object.get_name())
    print('handleTextList->path', path)
    object.export_native(path + '.xml', False)
    tree = ET.parse(path + '.xml')
    root = tree.getroot()
    list = {"TextList": [], "LanguageList": []}
    textList = root.find('./StructuredView/Single/List2/Single/Single/List[@Name="TextList"]')
    for child in textList:
        textID = child.find("./Single/[@Name='TextID']")
        if textID.text:
            list["TextList"].append({
                "TextID": int(textID.text),
                "TextDefault": child.find("./Single/[@Name='TextDefault']").text,
                "LanguageTexts": xMLListToPythList(child.find("./List/[@Name='LanguageTexts']"))
            })
    languageList = root.find('./StructuredView/Single/List2/Single/Single/List[@Name="Languages"]')
    list["LanguageList"] = xMLListToPythList(languageList)
    writeDataToFile(json.dumps(list, indent=4), path + '.json')
    os.remove(path + '.xml')


def handleLibrary(object, path):
    path = os.path.join(path, "%LIB%" + object.get_name())
    print('handleLibrary->path', path)
    object.export_native(path + '.xml', False)
    tree = ET.parse(path + '.xml')
    # os.remove(path + '.xml')
    root = tree.getroot()
    list = {"libraries": [], "placeholders": []}
    libList = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/List')
    for item in libList:
        params = item.find('./Array[@Name="Params"]')
        paramsList = []
        if len(params) > 0:
            for param in params:
                paramsList.append({
                    "name": param.find('./Single[@Name="Name"]').text,
                    "positionToSave": param.find('./Single[@Name="Exp"]/Single[@Name="PositionToSave"]').text,
                    "longValue": param.find('./Single[@Name="Exp"]/Single[@Name="LongValue"]').text,
                    "typeClass": param.find('./Single[@Name="Exp"]/Single[@Name="TypeClass"]').text,
                    "negative": param.find('./Single[@Name="Exp"]/Single[@Name="Negative"]').text,
                    "originalTypeClass": param.find('./Single[@Name="Exp"]/Single[@Name="OriginalTypeClass"]').text,
                })
        list['libraries'].append({
            "defaultResolution": item.find('./Single[@Name="DefaultResolution"]').text,
            "optional": item.find('./Single[@Name="Optional"]').text,
            "placeholderName": item.find('./Single[@Name="PlaceholderName"]').text,
            "resolverGuid": item.find('./Single[@Name="ResolverGuid"]').text,
            "id": item.find('./Single[@Name="Id"]').text,
            "namespace": item.find('./Single[@Name="Namespace"]').text,
            "systemLibrary": item.find('./Single[@Name="SystemLibrary"]').text,
            "hideWhenReferencedAsDependency": item.find('./Single[@Name="HideWhenReferencedAsDependency"]').text,
            "publishSymbolsInContainer": item.find('./Single[@Name="PublishSymbolsInContainer"]').text,
            "qualifiedOnly": item.find('./Single[@Name="QualifiedOnly"]').text,
            "linkAllContent": item.find('./Single[@Name="LinkAllContent"]').text,
            "params": paramsList,
        })
    placeList = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/Dictionary[@Name="PlaceholderRedirectionTable"]')
    for item in placeList:
        list['placeholders'].append({
            "key": item.find('./Key/Single').text,
            "value": item.find('./Value/Single').text,
        })
    writeDataToFile(json.dumps(list, indent=4), path + '.json')


def handlePLCKBUS(object, path):
    tempPath = os.path.join(path, "%PLCKBUS%" + object.get_name())
    print('handlePLCKBUS->path', tempPath)
    object.export_native(tempPath + '.xml', False)
    tree = ET.parse(tempPath + '.xml')
    #os.remove(tempPath + '.xml')
    root = tree.getroot()
    list = {}
    if root.find('./StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Single[@Name="Name"]').text == 'Kbus':
        deviceInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/Single[@Name="DefaultDeviceInfo"]')
        list['name'] = deviceInfo.find('./Single[@Name="Name"]').text
        list['vendor'] = deviceInfo.find('./Single[@Name="Vendor"]').text
        path = os.path.join(path, "%KBUS%" + object.get_name())
        writeDataToFile(json.dumps(list, indent=4), path + '.json')
    else:
        deviceInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/Single[@Name="DefaultDeviceInfo"]')
        list['name'] = deviceInfo.find('./Single[@Name="Name"]').text
        list['vendor'] = deviceInfo.find('./Single[@Name="Vendor"]').text
        list['ordernumber'] = deviceInfo.find('./Single[@Name="OrderNumber"]').text
        networkInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/List2[@Name="ProtocolAddresses"]/Single/Single[@Name="Address"]')
        list['ipaddress'] = networkInfo.text
        path = os.path.join(path, "%PLC%" + object.get_name())
        writeDataToFile(json.dumps(list, indent=4), path + '.json')
        loopObjects(object, path)


def handleApplication(object, path):
    path = os.path.join(path, "%APP%" + object.get_name())
    print('handleApplication->path', path)
    object.export_native(path + '.xml', False)


def handleProjectSettings(object, path):
    print('handleProjectSettings->path', path)
    handleNativeExport(object, os.path.join(path, "%PS%" + object.get_name()) + '.xml')


def handleVisuStyle(object, path):
    path = os.path.join(path, "%VS%" + object.get_name())
    print('handleVisuStyle->path', path)
    object.export_native(path + '.xml', False)


def handleVisualization(object, path):
    print('handleVisualization->path', path)
    handleNativeExport(object, os.path.join(path, "%VISU%" + object.get_name()) + '.xml')


def handleImagePool(object, path):
    path = os.path.join(path, "%IMP%" + object.get_name())
    print('handleImagePool->path', path)
    object.export_native(path + '.xml', False)
    tree = ET.parse(path + '.xml')
    os.remove(path + '.xml')
    root = tree.getroot()
    list = {"imagepool": [], "imagedata": []}
    imageList = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/List[@Name="BitmapPool"]')
    for item in imageList:
        id = item.find('./Single[@Name="BitmapID"]').text
        print(id)
        if id:
            list['imagepool'].append({"id": id, "fileID": item.find('./Single[@Name="FileID"]').text, "itemID": item.find('./Single[@Name="ItemID"]').text})
    imageData = root.findall('./StructuredView/Single/List2/Single[@Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}"]')
    for item in imageData:
        updateMode = item.find('./Single[@Name="Object"]/Single[@Name="AutoUpdateMode"]')
        if updateMode is not None:
            list['imagedata'].append({
                "name": item.find('./Single[@Name="MetaObject"]/Single[@Name="Name"]').text,
                "guid": item.find('./Single[@Name="MetaObject"]/Single[@Name="Guid"]').text,
                "autoUpdateMode": updateMode.text,
                "data": item.find('./Single[@Name="Object"]/Array[@Name="Data"]').text,
                "frozen": item.find('./Single[@Name="Object"]/Single[@Name="Frozen"]').text})
    writeDataToFile(json.dumps(list, indent=4), path + '.json')


timeStampFinder = re.compile(r"(<Single Name=\"Timestamp\" Type=\"long\">)(\d+)(<\/Single>)")


def handleNativeExport(object, path):
    print('handleNativeExport->path', path)
    object.export_native(path, False)
    editedFile = timeStampFinder.sub('\\1 0 \\3', fileContent(path))
    writeDataToFile(editedFile, path)


def handleObject(object, path):
    tryPrintObjectName('handleObject->object', object)
    type = str(object.type)
    print('handleObject->type', type)
    if type == '8753fe6f-4a22-4320-8103-e553c4fc8e04':  # Project Settings
        handleProjectSettings(object, path)
    elif type == '738bea1e-99bb-4f04-90bb-a7a567e74e3a':  # Folder
        handleFolder(object, path)
    elif type == 'adb5cb65-8e1d-4a00-b70a-375ea27582f3':  # Library Manager
        handleLibrary(object, path)
    elif type == 'ffbfa93a-b94d-45fc-a329-229860183b1d':  # GVL
        handleTextType(object, path, '%GVL%')
    elif type == '6f9dac99-8de1-4efc-8465-68ac443b7d08':  # POU
        handleTextType(object, path, '%POU%')
    elif type == '8ac092e5-3128-4e26-9e7e-11016c6684f2':  # POU Action
        handleTextType(object, path, '%ACT%')
    elif type == 'f8a58466-d7f6-439f-bbb8-d4600e41d099':  # POU Method
        handleTextType(object, path, '%METH%')
    elif type == '5a3b8626-d3e9-4f37-98b5-66420063d91e':  # POU Property
        handleTextType(object, path, '%PRO%')
    elif type == '792f2eb6-721e-4e64-ba20-bc98351056db':  # POU Property Getter/Setter
        handleTextType(object, path, '%GETSET%')
    elif type == 'a10c6218-cb94-436f-91c6-e1652575253d':  # POU Transition
        handleTextType(object, path, '%TRAN%')
    elif type == '2db5746d-d284-4425-9f7f-2663a34b0ebc':  # DUT
        handleTextType(object, path, '%DUT%')
    elif type == '6654496c-404d-479a-aad2-8551054e5f1e':  # ITF
        handleTextType(object, path, '%ITF%')
    elif type == 'f89f7675-27f1-46b3-8abb-b7da8e774ffd':  # ITF Method
        handleTextType(object, path, '%METH%')
    elif type == '5a3b8626-d3e9-4f37-98b5-66420063d91e':  # ITF Property
        handleTextType(object, path, '%PRO%')
    elif type == '28747452-a93d-4b34-8d05-d2c6018edd7d':  # ITF Property Getter/Setter
        handleTextType(object, path, '%GETSET%')
    elif type == '8e687a04-7ca7-42d3-be06-fcbda676c5ef':  # VisualizationStyle
        return ''
    elif type == 'f18bec89-9fef-401d-9953-2f11739a6808':  # Visualization
        handleVisualization(object, path)
    elif type == '63784cbb-9ba0-45e6-9d69-babf3f040511':  # GlobalTextList
        handleTextList(object, path, True)
    elif type == '2bef0454-1bd3-412a-ac2c-af0f31dbc40f':  # TextList
        handleTextList(object, path, False)
    elif type == '9031c721-d39f-4557-8a8f-ab12b4a71ebc':  # UnitConversion
        print('handleObject->UnsupportedType(UnitConversion)', type)
    elif type == 'bb0b9044-714e-4614-ad3e-33cbdf34d16b':  # ImagePool
        handleImagePool(object, path)
    elif type == 'a56744ff-693f-4597-95f9-0e1c529fffc2':  # External File
        handleExternalFile(object, path)
    elif type == 'ae1de277-a207-4a28-9efb-456c06bd52f3':  # Task Configuration
        handleTaskConfiguration(object)
    elif type == '':  # Task
        return ''
    elif type == '225bfe47-7336-4dbc-9419-4105a7c831fa':  # Kbus/PLC
        handlePLCKBUS(object, path)
    elif type == '639b491f-5557-464c-af91-1471bac9f549':  # Application
        handleApplication(object, path)
    else:
        path = os.path.join(path, "%UNKNOWN%" + object.get_name())
        print('Unknown type ' + object.get_name() + ' ' + str(type))
        return path


root = os.path.join(sys.argv[1], "src")
if os.path.exists(root):
    shutil.rmtree(root)
loopObjects(project, root)

# e_system.close_e_cockpit()
