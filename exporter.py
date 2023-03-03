# We enable the new python 3 print syntax
from __future__ import print_function
import sys
import os
import re
import shutil
import xml.etree.ElementTree as ET
import json
import string

shutil.copyfile(os.path.join(sys.argv[1], 'ecp', "src.ecp"), os.path.join(sys.argv[1], 'ecp_at_export', "src.ecp"))
project = e_projects.open_project(os.path.join(sys.argv[1], 'ecp', "src.ecp"))

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Helpers


def tryPrintObjectName(text, obj):
    return
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
        list.append(child.text or '')
    return list


def textExportDeclImpl(object, path):
    f = open(path + '.st', 'w')
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text.encode('utf-8'))
    f.write('\n(*%!%__DELIMITER__%!%*)\n')
    if object.has_textual_implementation:
        f.write(object.textual_implementation.text.encode('utf-8'))
    f.close()


def textExportDecl(object, path):
    f = open(path + '.st', 'w')
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text.encode('utf-8'))
    f.close()


def textExportImpl(object, path):
    f = open(path + '.st', 'w')
    if object.has_textual_implementation:
        f.write(object.textual_implementation.text.encode('utf-8'))
    f.close()


timeStampFinder = re.compile(r"(<Single Name=\"Timestamp\" Type=\"long\">)(\d+)(<\/Single>)")


def handleNativeExport(object, path, recursive):
    #print('handleNativeExport->path', path)
    object.export_native(path, recursive)
    editedFile = timeStampFinder.sub('\\1 0 \\3', fileContent(path))
    writeDataToFile(editedFile, path)


###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Handlers


def handleFolder(object, path):
    path = os.path.join(path, "%F%" + object.get_name())
    writeDataToFile('', path + '.txt')
    loopObjects(object, path)


###########################################################################################################################################
# Normals / Members
def handleTextType(object, path, designator):
    path = os.path.join(path, designator + object.get_name())
    #print('handleTextType->path', path)
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


def handlePersistentVariables(object, path):
    path = os.path.join(path, "%PV%" + object.get_name())
    #print('handlePersistentVariables->path', path)
    handleNativeExport(object, path + '.xml', False)
    loopObjects(object, path)

###########################################################################################################################################
# Specials


def handleTextList(object, path, isGlobal):
    if isGlobal:
        path = os.path.join(path, "%AGTL%" + object.get_name())
    else:
        path = os.path.join(path, "%TL%" + object.get_name())
    #print('handleTextList->path', path)
    object.export_native(path + '.xml', False)
    tree = ET.parse(path + '.xml')
    root = tree.getroot()
    list = {"TextList": [], "LanguageList": []}
    textList = root.find('./StructuredView/Single/List2/Single/Single/List[@Name="TextList"]')
    for child in textList:
        textID = child.find("./Single/[@Name='TextID']")
        if textID.text:
            list["TextList"].append({
                "TextID": int(textID.text or ''),
                "TextDefault": child.find("./Single/[@Name='TextDefault']").text or '',
                "LanguageTexts": xMLListToPythList(child.find("./List/[@Name='LanguageTexts']"))
            })
    languageList = root.find('./StructuredView/Single/List2/Single/Single/List[@Name="Languages"]')
    list["LanguageList"] = xMLListToPythList(languageList)
    writeDataToFile(json.dumps(list, indent=4), path + '.json')
    os.remove(path + '.xml')


def handleImagePool(object, path):
    path = os.path.join(path, "%IMP%" + object.get_name())
    #print('handleImagePool->path', path)
    object.export_native(path + '.xml', False)
    tree = ET.parse(path + '.xml')
    os.remove(path + '.xml')
    root = tree.getroot()
    list = {"imagepool": [], "imagedata": []}
    imageList = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/List[@Name="BitmapPool"]')
    for item in imageList:
        id = item.find('./Single[@Name="BitmapID"]').text
        if id:
            list['imagepool'].append({"id": id, "fileID": item.find('./Single[@Name="FileID"]').text or '', "itemID": item.find('./Single[@Name="ItemID"]').text or ''})
    imageData = root.findall('./StructuredView/Single/List2/Single[@Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}"]')
    for item in imageData:
        updateMode = item.find('./Single[@Name="Object"]/Single[@Name="AutoUpdateMode"]')
        if updateMode is not None:
            list['imagedata'].append({
                "name": item.find('./Single[@Name="MetaObject"]/Single[@Name="Name"]').text or '',
                "guid": item.find('./Single[@Name="MetaObject"]/Single[@Name="Guid"]').text or '',
                "autoUpdateMode": updateMode.text or '',
                "data": item.find('./Single[@Name="Object"]/Array[@Name="Data"]').text or '',
                "frozen": item.find('./Single[@Name="Object"]/Single[@Name="Frozen"]').text or ''})
    writeDataToFile(json.dumps(list, indent=4), path + '.json')


def handleProjectSettings(object, path):
    #print('handleProjectSettings->path', path)
    handleNativeExport(object, os.path.join(path, "%PS%" + object.get_name()) + '.xml', False)


def handleLibrary(object, path):
    path = os.path.join(path, "%ALIB%" + object.get_name())
    print('handleLibrary->path', path)
    references = object.references
    print('handleLibrary->references', references)
    list = {"libraries": [], "placeholders": []}
    for ref in references:
        print('handleLibrary->ref', ref)
        if ref.is_placeholder:
            list['placeholders'].append({
                "is_managed": ref.is_managed,
                "name": ref.name,
                "namespace": ref.namespace,
                "system_library": ref.system_library,
                "qualified_only": ref.qualified_only,
                "placeholder_name": ref.placeholder_name,
                "default_resolution": ref.default_resolution,
                "effective_resolution": ref.effective_resolution,
                "is_redirected": ref.is_redirected,
                "resolution_info": ref.resolution_info,
            })
        else:
            list['libraries'].append({
                "is_managed": ref.is_managed,
                "name": ref.name,
                "namespace": ref.namespace,
                "system_library": ref.system_library,
                "qualified_only": ref.qualified_only,
                "optional": ref.optional,
            })

    print(list)
    writeDataToFile(json.dumps(list, indent=4), path + '.json')


def handleSymbols(object, path):
    #print('handleSymbols->path', path)
    handleNativeExport(object, os.path.join(path, "%SYM%" + object.get_name()) + '.xml', False)

###########################################################################################################################################
# Visu


def handleVisualization(object, path):
    #print('handleVisualization->path', path)
    handleNativeExport(object, os.path.join(path, "%VISU%" + object.get_name()) + '.xml', False)


def handleVisualizationManager(object, path):
    #print('handleVisualizationManager->path', path)
    handleNativeExport(object, os.path.join(path, "%VIMA%" + object.get_name()) + '.xml', False)


def handleVisuStyle(object, path):
    #print('handleVisuStyle->path', path)
    handleNativeExport(object, os.path.join(path, "%VS%" + object.get_name()) + '.xml', False)


###########################################################################################################################################
# PLC
def handlePLCKBUS(object, path):
    tempPath = os.path.join(path, "%PLCKBUS%" + object.get_name())
    #print('handlePLCKBUS->path', tempPath)
    object.export_native(tempPath + '.xml', False)
    tree = ET.parse(tempPath + '.xml')
    os.remove(tempPath + '.xml')
    root = tree.getroot()
    list = {}
    if root.find('./StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Single[@Name="Name"]').text == 'Kbus':
        object.export_io_mappings_as_csv(os.path.join(path, "%KBUS%" + object.get_name() + ".csv"))
    else:
        deviceInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/Single[@Name="DefaultDeviceInfo"]')
        list['name'] = deviceInfo.find('./Single[@Name="Name"]').text or ''
        list['vendor'] = deviceInfo.find('./Single[@Name="Vendor"]').text or ''
        list['ordernumber'] = deviceInfo.find('./Single[@Name="OrderNumber"]').text or ''
        networkInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/List2[@Name="ProtocolAddresses"]/Single/Single[@Name="Address"]')
        list['ipaddress'] = networkInfo.text or ''
        versionInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/Single[@Name="DeviceTypeVersion"]')
        list['version'] = versionInfo.text or ''
        path = os.path.join(path, "%PLC%" + object.get_name())
        list['modules'] = []
        children = object.find('Kbus')[0].get_children(False)
        if len(children) > 0:
            for index, child in enumerate(children):
                child.export_native(tempPath + '%' + str(index) + '.xml', False)
                tree = ET.parse(tempPath + '%' + str(index) + '.xml')
                os.remove(tempPath + '%' + str(index) + '.xml')
                root = tree.getroot()
                deviceInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="Object"]/Single[@Name="DefaultDeviceInfo"]')
                versionInfo = root.find('./StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/Single[@Name="DeviceTypeVersion"]')
                list['modules'].append({
                    'name': deviceInfo.find('./Single[@Name="Name"]').text or '',
                    'vendor': deviceInfo.find('./Single[@Name="Vendor"]').text or '',
                    'ordernumber': deviceInfo.find('./Single[@Name="OrderNumber"]').text or '',
                    'version': versionInfo.text or '',
                })
        writeDataToFile(json.dumps(list, indent=4), path + '.json')
        loopObjects(object, path)


def handlePLCLogic(object, path):
    path = os.path.join(path, "%PLOG%" + object.get_name())
    #print('handlePLCLogic->path', path)
    handleNativeExport(object, path + '.xml', False)
    loopObjects(object, path)


def handleApplication(object, path):
    path = os.path.join(path, "%APP%" + object.get_name())
    #print('handleApplication->path', path)
    handleNativeExport(object, path + '.xml', False)
    loopObjects(object, path)


def handleTaskConfiguration(object, path):
    path = os.path.join(path, "%TC%" + object.get_name())
    #print('handleTaskConfiguration->path', path)
    handleNativeExport(object, path + '.xml', False)
    loopObjects(object, path)


def handleTask(object, path):
    path = os.path.join(path, "%TSK%" + object.get_name())
    #print('handleTask->path', path)
    handleNativeExport(object, path + '.xml', False)


def handleConnection(object, path):
    #print('handleConnection->path', path)
    handleNativeExport(object, os.path.join(path, "%CONN%" + object.get_name()) + '.xml', False)
    loopObjects(object, path)

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Loopers


def handleObject(object, path):
    tryPrintObjectName('handleObject->object', object)
    type = str(object.type)
    #print('handleObject->type', type)
    if type == '738bea1e-99bb-4f04-90bb-a7a567e74e3a':  # Folder
        handleFolder(object, path)
    # Normals
    elif type == '6f9dac99-8de1-4efc-8465-68ac443b7d08':  # POU
        handleTextType(object, path, '%POU%')
    elif type == '2db5746d-d284-4425-9f7f-2663a34b0ebc':  # DUT
        handleTextType(object, path, '%DUT%')
    elif type == 'ffbfa93a-b94d-45fc-a329-229860183b1d':  # GVL
        handleTextType(object, path, '%GVL%')
    elif type == '6654496c-404d-479a-aad2-8551054e5f1e':  # ITF
        handleTextType(object, path, '%ITF%')
    elif type == '261bd6e6-249c-4232-bb6f-84c2fbeef430':  # Persisten Vars
        handlePersistentVariables(object, path)
    # Members
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
    elif type == 'f89f7675-27f1-46b3-8abb-b7da8e774ffd':  # ITF Method
        handleTextType(object, path, '%METH%')
    elif type == '5a3b8626-d3e9-4f37-98b5-66420063d91e':  # ITF Property
        handleTextType(object, path, '%PRO%')
    elif type == '28747452-a93d-4b34-8d05-d2c6018edd7d':  # ITF Property Getter/Setter
        handleTextType(object, path, '%GETSET%')
    # Specials
    elif type == '2bef0454-1bd3-412a-ac2c-af0f31dbc40f':  # TextList
        handleTextList(object, path, False)
    elif type == '63784cbb-9ba0-45e6-9d69-babf3f040511':  # GlobalTextList
        handleTextList(object, path, True)
    elif type == 'bb0b9044-714e-4614-ad3e-33cbdf34d16b':  # ImagePool
        handleImagePool(object, path)
    elif type == '8753fe6f-4a22-4320-8103-e553c4fc8e04':  # Project Settings
        handleProjectSettings(object, path)
    elif type == 'adb5cb65-8e1d-4a00-b70a-375ea27582f3':  # Library Manager
        handleLibrary(object, path)
    # Visu
    elif type == '8e687a04-7ca7-42d3-be06-fcbda676c5ef':  # VisualizationStyle
        return ''
    elif type == 'f18bec89-9fef-401d-9953-2f11739a6808':  # Visualization
        handleVisualization(object, path)
    elif type == '4d3fdb8f-ab50-4c35-9d3a-d4bb9bb9a628':  # Visualization Manager
        handleVisualizationManager(object, path)
    # PLC
    elif type == '225bfe47-7336-4dbc-9419-4105a7c831fa':  # Kbus/PLC
        handlePLCKBUS(object, path)
    elif type == '40b404f9-e5dc-42c6-907f-c89f4a517386':  # PLC Logic
        handlePLCLogic(object, path)
    elif type == '639b491f-5557-464c-af91-1471bac9f549':  # Application
        handleApplication(object, path)
    elif type == 'ae1de277-a207-4a28-9efb-456c06bd52f3':  # Task Configuration
        handleTaskConfiguration(object, path)
    elif type == '98a2708a-9b18-4f31-82ed-a1465b24fa2d':  # Task
        handleTask(object, path)
    # Unsupported
    # elif type == 'a56744ff-693f-4597-95f9-0e1c529fffc2':  # External File
    #     #print('handleObject->UnsupportedType(External File)', type)
    # elif type == '9031c721-d39f-4557-8a8f-ab12b4a71ebc':  # Unit Conversion
    #     #print('handleObject->UnsupportedType(Unit Conversion)', type)
    # elif type == '9031c721-d39f-4557-8a8f-ab12b4a71ebc':  # RecipeManager
    #     #print('handleObject->UnsupportedType(RecipeManager)', type)
    # elif type == '9031c721-d39f-4557-8a8f-ab12b4a71ebc':  # Trace
    #     #print('handleObject->UnsupportedType(Trace)', type)
    # elif type == '9031c721-d39f-4557-8a8f-ab12b4a71ebc':  # Trend Recording Manager
    #     #print('handleObject->UnsupportedType(Trend Recording Manager)', type)
    # else:
    #     path = os.path.join(path, "%UNKNOWN%" + object.get_name())
    #     #print('Unknown type ' + object.get_name() + ' ' + str(type))
    #     return path


def loopObjects(object, path):
    children = object.get_children(False)
    if len(children) > 0:
        if not os.path.exists(path):
            os.makedirs(path)
        for child in children:
            handleObject(child, path)


root = os.path.join(sys.argv[1], "src")
if os.path.exists(root):
    shutil.rmtree(root)
loopObjects(project, root)

# e_system.close_e_cockpit()
