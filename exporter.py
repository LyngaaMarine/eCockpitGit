# We enable the new python 3 print syntax
from __future__ import print_function
import io
import sys
import os
import re
import shutil
import xml.etree.ElementTree as ET
import json

#############################################################
#    ______                _   _
#   |  ____|              | | (_)
#   | |__ _   _ _ __   ___| |_ _  ___  _ __  ___
#   |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#   | |  | |_| | | | | (__| |_| | (_) | | | \__ \
#   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Helper Functions


def tryPrintObjectName(text, obj):
    try:
        print(text, obj.get_name())
    except:
        print(text, "root")


def encodeMatch(match):
    return "{" + str(ord(match.group(0))) + "}"


def encodeObjectName(object):
    name = re.sub(r"[^A-Za-z0-9 _-]", encodeMatch, object.get_name())
    return name


def getTypeSafe(object):
    if hasattr(object, "type"):
        return str(object.type)
    else:
        return "root"


def fileContent(path):
    f = open(path, "r")
    data = f.read()
    f.close()
    return data


def writeDataToFile(data, path):
    f = open(path, "w")
    f.write(data)
    f.close()


def writeDataToFileUTF8(data, path):
    f = io.open(file=path, mode="w", encoding="utf-8")
    f.write(data.encode().decode("unicode_escape"))
    f.close()


def xMLListToPythList(element):
    list = []
    for child in element:
        list.append(child.text or "")
    return list


def textExportDeclImpl(object, path):
    f = open(path + ".st", "w")
    f.write(
        json.dumps(getObjectBuildProperties(object), indent=2) + "\n!__DECLARATION__!\n"
    )
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text.encode("utf-8"))
    f.write("\n!__IMPLEMENTATION__!\n")
    if object.has_textual_implementation:
        f.write(object.textual_implementation.text.encode("utf-8"))
    f.close()


def textExportDecl(object, path):
    f = open(path + ".st", "w")
    f.write(
        json.dumps(getObjectBuildProperties(object), indent=2) + "\n!__DECLARATION__!\n"
    )
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text.encode("utf-8"))
    f.close()


def textExportImpl(object, path):
    f = open(path + ".st", "w")
    f.write(
        json.dumps(getObjectBuildProperties(object), indent=2) + "\n!__DECLARATION__!\n"
    )
    if object.has_textual_implementation:
        f.write(object.textual_implementation.text.encode("utf-8"))
    f.close()


timeStampFinder = re.compile(
    r"(<Single Name=\"Timestamp\" Type=\"long\">)(\d+)(<\/Single>)"
)


def handleNativeExport(object, path, recursive):
    object.export_native(path, recursive)
    editedFile = timeStampFinder.sub("\\1 0 \\3", fileContent(path))
    writeDataToFile(editedFile, path)


def getObjectBuildProperties(object):
    list = {}
    props = object.build_properties
    if props:
        if props.external_is_valid:
            list["external"] = props.external
        if props.enable_system_call_is_valid:
            list["enable_system_call"] = props.enable_system_call
        if props.compiler_defines_is_valid:
            list["compiler_defines"] = props.compiler_defines
        if props.link_always_is_valid:
            list["link_always"] = props.link_always
        if props.exclude_from_build_is_valid:
            list["exclude_from_build"] = props.exclude_from_build
    return list


###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Object Handlers


###########################################################################################################################################
# Folder
def handleFolder(object, path):
    path = os.path.join(path, "%F%" + encodeObjectName(object))
    writeDataToFileUTF8(
        json.dumps(getObjectBuildProperties(object), indent=2), path + ".json"
    )
    loopObjects(object, path)


###########################################################################################################################################
# Normals / Members
def handleTextType(object, path, designator):
    path = os.path.join(path, designator + encodeObjectName(object))
    if designator == "%POU%":
        textExportDeclImpl(object, path)
    elif designator == "%METH%":
        textExportDeclImpl(object, path)
    elif designator == "%TRAN%":
        textExportImpl(object, path)
    else:
        textExportDecl(object, path)
    loopObjects(object, path)


def handleProperty(object, path):
    path = os.path.join(path, "%PRO%" + encodeObjectName(object))
    f = open(path + ".st", "w")
    f.write(
        json.dumps(getObjectBuildProperties(object), indent=2) + "\n!__DECLARATION__!\n"
    )
    if object.has_textual_declaration:
        f.write(object.textual_declaration.text.encode("utf-8"))
    f.write("\n!__GETTER__!\n")
    get = object.find("Get")
    if len(get) > 0:
        getter = get[0]
        if getter:
            if getter.has_textual_declaration:
                f.write(getter.textual_declaration.text.encode("utf-8"))
            f.write("\n!__IMPLEMENTATION__!\n")
            if getter.has_textual_implementation:
                f.write(getter.textual_implementation.text.encode("utf-8"))
    f.write("\n!__SETTER__!\n")
    set = object.find("Set")
    if len(set) > 0:
        setter = set[0]
        if setter:
            if setter.has_textual_declaration:
                f.write(setter.textual_declaration.text.encode("utf-8"))
            f.write("\n!__IMPLEMENTATION__!\n")
            if setter.has_textual_implementation:
                f.write(setter.textual_implementation.text.encode("utf-8"))
    f.close()


def handlePersistentVariables(object, path):
    path = os.path.join(path, "%PV%" + encodeObjectName(object))
    handleNativeExport(object, path + ".xml", False)
    loopObjects(object, path)


###########################################################################################################################################
# Specials
def handleTextList(object, path, isGlobal):
    if isGlobal:
        return
        # Global textlist is ignored as it is generated again every time
        # path = os.path.join(path, "%GTL%" + encodeObjectName(object))
    else:
        path = os.path.join(path, "%TL%" + encodeObjectName(object))
    allInfo = {
        "BuildProperties": getObjectBuildProperties(object),
        "TextList": [],
        "LanguageList": [],
    }
    for row in object.rows:
        texts = []
        for i in range(row.languagetextcount()):
            texts.append(row.languagetext(i).replace("\r\r\r\n", "\r\n"))
        allInfo["TextList"].append(
            {"TextID": row.id, "TextDefault": row.defaulttext, "LanguageTexts": texts}
        )
    for i in range(object.languagecount()):
        allInfo["LanguageList"].append(object.getlanguage(i))
    writeDataToFile(json.dumps(allInfo, indent=2), path + ".json")


def handleImagePool(object, path):
    path = os.path.join(path, "%IMP%" + encodeObjectName(object))
    object.export_native(path + ".xml", False)
    tree = ET.parse(path + ".xml")
    os.remove(path + ".xml")
    root = tree.getroot()
    list = {
        "BuildProperties": getObjectBuildProperties(object),
        "imagepool": [],
        "imagedata": [],
    }
    imageList = root.find(
        './StructuredView/Single/List2/Single/Single[@Name="Object"]/List[@Name="BitmapPool"]'
    )
    for item in imageList:
        id = item.find('./Single[@Name="BitmapID"]').text
        if id:
            list["imagepool"].append(
                {
                    "id": id,
                    "fileID": item.find('./Single[@Name="FileID"]').text or "",
                    "itemID": item.find('./Single[@Name="ItemID"]').text or "",
                }
            )
    imageData = root.findall(
        './StructuredView/Single/List2/Single[@Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}"]'
    )
    for item in imageData:
        updateMode = item.find(
            './Single[@Name="Object"]/Single[@Name="AutoUpdateMode"]'
        )
        if updateMode is not None:
            list["imagedata"].append(
                {
                    "name": item.find(
                        './Single[@Name="MetaObject"]/Single[@Name="Name"]'
                    ).text
                    or "",
                    "guid": item.find(
                        './Single[@Name="MetaObject"]/Single[@Name="Guid"]'
                    ).text
                    or "",
                    "autoUpdateMode": updateMode.text or "",
                    "data": item.find(
                        './Single[@Name="Object"]/Array[@Name="Data"]'
                    ).text
                    or "",
                    "frozen": item.find(
                        './Single[@Name="Object"]/Single[@Name="Frozen"]'
                    ).text
                    or "",
                }
            )
    writeDataToFile(json.dumps(list, indent=2), path + ".json")


def handleProjectSettings(object, path):
    handleNativeExport(
        object, os.path.join(path, "%PS%" + encodeObjectName(object)) + ".xml", False
    )


def handleLibrary(object, path):
    path = os.path.join(path, "%LIB%" + encodeObjectName(object))
    references = object.references
    list = {
        "BuildProperties": getObjectBuildProperties(object),
        "libraries": [],
        "placeholders": [],
    }
    for ref in references:
        if ref.is_placeholder:
            list["placeholders"].append(
                {
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
                }
            )
        else:
            list["libraries"].append(
                {
                    "is_managed": ref.is_managed,
                    "name": ref.name,
                    "namespace": ref.namespace,
                    "system_library": ref.system_library,
                    "qualified_only": ref.qualified_only,
                    "optional": ref.optional,
                }
            )
    writeDataToFileUTF8(json.dumps(list, indent=2), path + ".json")


def handleSymbols(object, path):
    handleNativeExport(
        object, os.path.join(path, "%SYM%" + encodeObjectName(object)) + ".xml", False
    )


###########################################################################################################################################
# Visu
def handleVisualization(object, path):
    handleNativeExport(
        object, os.path.join(path, "%VISU%" + encodeObjectName(object)) + ".xml", False
    )


def handleVisualizationManager(object, path):
    handleNativeExport(
        object, os.path.join(path, "%VIMA%" + encodeObjectName(object)) + ".xml", True
    )


def handleVisuStyle(object, path):
    handleNativeExport(
        object, os.path.join(path, "%VS%" + encodeObjectName(object)) + ".xml", False
    )


###########################################################################################################################################
# PLC
def handlePLCKBUS(object, path):
    tempPath = os.path.join(path, "%PLCKBUS%" + encodeObjectName(object))
    object.export_native(tempPath + ".xml", False)
    tree = ET.parse(tempPath + ".xml")
    os.remove(tempPath + ".xml")
    root = tree.getroot()
    list = {"BuildProperties": getObjectBuildProperties(object)}
    if (
        root.find(
            './StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Single[@Name="Name"]'
        ).text
        == "Kbus"
    ):
        object.export_io_mappings_as_csv(
            os.path.join(path, "%KBUS%" + encodeObjectName(object) + ".csv")
        )
    else:
        deviceInfo = root.find(
            './StructuredView/Single/List2/Single/Single[@Name="Object"]/Single[@Name="DefaultDeviceInfo"]'
        )
        list["name"] = deviceInfo.find('./Single[@Name="Name"]').text or ""
        list["vendor"] = deviceInfo.find('./Single[@Name="Vendor"]').text or ""
        list["ordernumber"] = (
            deviceInfo.find('./Single[@Name="OrderNumber"]').text or ""
        )
        networkInfo = root.find(
            './StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/List2[@Name="ProtocolAddresses"]/Single/Single[@Name="Address"]'
        )
        list["ipaddress"] = networkInfo.text or ""
        versionInfo = root.find(
            './StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/Single[@Name="DeviceTypeVersion"]'
        )
        list["version"] = versionInfo.text or ""
        path = os.path.join(path, "%PLC%" + encodeObjectName(object))
        list["modules"] = []
        children = object.find("Kbus")[0].get_children(False)
        if len(children) > 0:
            for index, child in enumerate(children):
                child.export_native(tempPath + "%" + str(index) + ".xml", False)
                tree = ET.parse(tempPath + "%" + str(index) + ".xml")
                os.remove(tempPath + "%" + str(index) + ".xml")
                root = tree.getroot()
                deviceInfo = root.find(
                    './StructuredView/Single/List2/Single/Single[@Name="Object"]/Single[@Name="DefaultDeviceInfo"]'
                )
                versionInfo = root.find(
                    './StructuredView/Single/List2/Single/Single[@Name="MetaObject"]/Dictionary/Entry/Value/Single/Single[@Name="DeviceTypeVersion"]'
                )
                list["modules"].append(
                    {
                        "name": deviceInfo.find('./Single[@Name="Name"]').text or "",
                        "vendor": deviceInfo.find('./Single[@Name="Vendor"]').text
                        or "",
                        "ordernumber": deviceInfo.find(
                            './Single[@Name="OrderNumber"]'
                        ).text
                        or "",
                        "version": versionInfo.text or "",
                    }
                )
        writeDataToFileUTF8(json.dumps(list, indent=2), path + ".json")
        loopObjects(object, path)


def handlePLCLogic(object, path):
    path = os.path.join(path, "%PLOG%" + encodeObjectName(object))
    handleNativeExport(object, path + ".xml", False)
    loopObjects(object, path)


def handleApplication(object, path):
    path = os.path.join(path, "%APP%" + encodeObjectName(object))
    handleNativeExport(object, path + ".xml", False)
    loopObjects(object, path)


def handleTaskConfiguration(object, path):
    path = os.path.join(path, "%TC%" + encodeObjectName(object))
    handleNativeExport(object, path + ".xml", False)
    loopObjects(object, path)


def handleTask(object, path):
    path = os.path.join(path, "%TSK%" + encodeObjectName(object))
    handleNativeExport(object, path + ".xml", False)


def handleConnection(object, path):
    path = os.path.join(path, "%CONN%" + encodeObjectName(object))
    handleNativeExport(object, path + ".xml", False)
    loopObjects(object, path)


###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Loopers
def handleObject(object, path):
    type = str(object.type)
    if type == "738bea1e-99bb-4f04-90bb-a7a567e74e3a":  # Folder
        handleFolder(object, path)
    # Normals
    elif type == "6f9dac99-8de1-4efc-8465-68ac443b7d08":  # POU
        handleTextType(object, path, "%POU%")
    elif (
        type == "2db5746d-d284-4425-9f7f-2663a34b0ebc"
        or type == "40989022-e4d2-4dc7-89d2-9a412930b20e"
    ):  # DUT
        handleTextType(object, path, "%DUT%")
    elif type == "ffbfa93a-b94d-45fc-a329-229860183b1d":  # GVL
        handleTextType(object, path, "%GVL%")
    elif type == "6654496c-404d-479a-aad2-8551054e5f1e":  # ITF
        handleTextType(object, path, "%ITF%")
    elif type == "261bd6e6-249c-4232-bb6f-84c2fbeef430":  # Persisten Vars
        handlePersistentVariables(object, path)
    # Members
    elif type == "8ac092e5-3128-4e26-9e7e-11016c6684f2":  # POU Action
        handleTextType(object, path, "%ACT%")
    elif type == "f8a58466-d7f6-439f-bbb8-d4600e41d099":  # POU Method
        handleTextType(object, path, "%METH%")
    elif type == "5a3b8626-d3e9-4f37-98b5-66420063d91e":  # POU Property
        handleProperty(object, path)
    elif type == "a10c6218-cb94-436f-91c6-e1652575253d":  # POU Transition
        handleTextType(object, path, "%TRAN%")
    elif type == "f89f7675-27f1-46b3-8abb-b7da8e774ffd":  # ITF Method
        handleTextType(object, path, "%METH%")
    elif type == "5a3b8626-d3e9-4f37-98b5-66420063d91e":  # ITF Property
        handleProperty(object, path)
    # Specials
    elif type == "2bef0454-1bd3-412a-ac2c-af0f31dbc40f":  # TextList
        handleTextList(object, path, False)
    elif type == "63784cbb-9ba0-45e6-9d69-babf3f040511":  # GlobalTextList
        handleTextList(object, path, True)
    elif type == "bb0b9044-714e-4614-ad3e-33cbdf34d16b":  # ImagePool
        handleImagePool(object, path)
    elif type == "8753fe6f-4a22-4320-8103-e553c4fc8e04":  # Project Settings
        handleProjectSettings(object, path)
    elif type == "adb5cb65-8e1d-4a00-b70a-375ea27582f3":  # Library Manager
        handleLibrary(object, path)
    # Visu
    elif type == "8e687a04-7ca7-42d3-be06-fcbda676c5ef":  # VisualizationStyle
        return ""
    elif type == "f18bec89-9fef-401d-9953-2f11739a6808":  # Visualization
        handleVisualization(object, path)
    elif type == "4d3fdb8f-ab50-4c35-9d3a-d4bb9bb9a628":  # Visualization Manager
        handleVisualizationManager(object, path)
    # PLC
    elif type == "225bfe47-7336-4dbc-9419-4105a7c831fa":  # Kbus/PLC
        handlePLCKBUS(object, path)
    elif type == "40b404f9-e5dc-42c6-907f-c89f4a517386":  # PLC Logic
        handlePLCLogic(object, path)
    elif type == "639b491f-5557-464c-af91-1471bac9f549":  # Application
        handleApplication(object, path)
    elif type == "ae1de277-a207-4a28-9efb-456c06bd52f3":  # Task Configuration
        handleTaskConfiguration(object, path)
    elif type == "98a2708a-9b18-4f31-82ed-a1465b24fa2d":  # Task
        handleTask(object, path)


def loopObjects(object, path):
    children = object.get_children(False)
    if len(children) > 0:
        if not os.path.exists(path):
            os.makedirs(path)
        for child in children:
            handleObject(child, path)


#######################################################################
#     _____           _       _      _____ _             _
#    / ____|         (_)     | |    / ____| |           | |
#   | (___   ___ _ __ _ _ __ | |_  | (___ | |_ __ _ _ __| |_ ___
#    \___ \ / __| '__| | '_ \| __|  \___ \| __/ _` | '__| __/ __|
#    ____) | (__| |  | | |_) | |_   ____) | || (_| | |  | |_\__ \
#   |_____/ \___|_|  |_| .__/ \__| |_____/ \__\__,_|_|   \__|___/
#                      | |
#                      |_|
#######################################################################
# Backup project before export
srcdir = os.path.join(sys.argv[1], "ecp")
backupdir = os.path.join(sys.argv[1], "ecp_at_export")
if not os.path.exists(backupdir):
    os.makedirs(backupdir)
shutil.copyfile(os.path.join(srcdir, "src.ecp"), os.path.join(backupdir, "src.ecp"))

# Empty src directory
root = os.path.join(sys.argv[1], "src")
if os.path.exists(root):
    shutil.rmtree(root)

# Open project file file
project = e_projects.open_project(os.path.join(srcdir, "src.ecp"))

# Loop all project objects
loopObjects(project, root)

# Close project
e_system.close_e_cockpit()
