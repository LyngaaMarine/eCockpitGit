# We enable the new python 3 print syntax
from __future__ import print_function
import sys
import os
import re
import json
import time
import io


###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Helpers


def tryPrintObjectName(text, obj):
    return
    try:
        print(text, obj.get_name())
    except:
        print(text, 'none/root')


def decodeMatch(match):
    return chr(int(match.group(1)))


def decodeObjectName(string):
    return re.sub(r"{(\d+)}", decodeMatch, string)


def getTypeSafe(object):
    if hasattr(object, 'type'):
        return str(object.type)
    else:
        return 'root'


def trueFind(object, name):
    children = object.get_children(False)
    if children:
        for child in children:
            if child.get_name() == name:
                return child


def trueFindDevice(name):
    for device in project.devices:
        if device.get_name() == name:
            return device


def checkIsTypeWhoCanHaveFolderAndMember(object):
    type = getTypeSafe(object)
    if type == 'ffbfa93a-b94d-45fc-a329-229860183b1d':  # GVL
        return True
    elif type == '6f9dac99-8de1-4efc-8465-68ac443b7d08':  # POU
        return True
    elif type == '2db5746d-d284-4425-9f7f-2663a34b0ebc':  # DUT
        return True
    elif type == '6654496c-404d-479a-aad2-8551054e5f1e':  # ITF
        return True
    else:
        return False


def fileContent(path):
    f = io.open(file=path, mode='r', encoding='utf-8')
    data = f.read()
    f.close()
    return data


tempFilePath = os.path.join(sys.argv[1], "tempFile")


def writeTempFile(data):
    f = io.open(file=tempFilePath, mode='w', encoding='utf-8')
    f.write(data)
    f.close()


def writeDeclerationAndImplementationToObject(object, data, defferEnable):
    parts = data.split('\n', 1)
    applyObjectBuildProperties(object, json.loads(parts[0]), defferEnable)
    parts = parts[1].split('!__IMPLEMENTATION__!', 1)
    object.textual_declaration.replace(parts[0][:-1])
    if object.has_textual_implementation:
        object.textual_implementation.append(parts[1][1:])


defferedEnable = []


def applyObjectBuildProperties(object, propsSet, defferEnable):
    props = object.build_properties
    if props:
        if props.external_is_valid and 'external' in propsSet:
            props.external = propsSet['external']
        if props.enable_system_call_is_valid and 'enable_system_call' in propsSet:
            props.enable_system_call = propsSet['enable_system_call']
        if props.compiler_defines_is_valid and 'compiler_defines' in propsSet and len(propsSet['compiler_defines']) > 0:
            props.compiler_defines = propsSet['compiler_defines']
        if props.link_always_is_valid and 'link_always' in propsSet:
            props.link_always = propsSet['link_always']
        if props.exclude_from_build_is_valid:
            if 'exclude_from_build' in propsSet:
                if defferEnable:
                    props.exclude_from_build = True
                    defferedEnable.append([props, propsSet['exclude_from_build']])
                else:
                    props.exclude_from_build = propsSet['exclude_from_build']


def finishedDefferedEnable():
    for item in defferedEnable:
        item[0].exclude_from_build = item[1]

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Handlers


def handleFolder(creationObject, placementObject, name, path, ext):
    creationObject.create_folder(name)
    finds = creationObject.find(name)
    if finds:
        self = finds[0]
        if self is None:
            self = trueFind(creationObject, name)
    if self:
        if placementObject:
            self.move(placementObject, -1)
        buildProps = json.loads(fileContent(path + ext))
        applyObjectBuildProperties(self, buildProps, False)
        if creationObject == placementObject:
            loopDir(creationObject, self, path, False)
        else:
            loopDir(self, None, path, False)


###########################################################################################################################################
# Normals
def handlePOU(creationObject, name, path, ext):
    pou = creationObject.create_pou(name, PouType.Program)
    writeDeclerationAndImplementationToObject(pou, fileContent(path + ext), True)
    loopDir(pou, pou, path, False)


def handleDUT(creationObject, name, path, ext):
    pou = creationObject.create_dut(name, DutType.Structure)
    parts = fileContent(path + ext).split('\n', 1)
    applyObjectBuildProperties(pou, json.loads(parts[0]), True)
    pou.textual_declaration.replace(parts[1])
    loopDir(pou, pou, path, False)


def handleGVL(creationObject, name, path, ext):
    pou = creationObject.create_gvl(name)
    parts = fileContent(path + ext).split('\n', 1)
    applyObjectBuildProperties(pou, json.loads(parts[0]), True)
    pou.textual_declaration.replace(parts[1])
    loopDir(pou, pou, path, False)


def handleInterface(creationObject, name, path, ext):
    pou = creationObject.create_interface(name)
    parts = fileContent(path + ext).split('\n', 1)
    applyObjectBuildProperties(pou, json.loads(parts[0]), True)
    pou.textual_declaration.replace(parts[1])
    loopDir(pou, pou, path, False)


def handlePersistentVariables(creationObject, name, path, ext):
    creationObject.import_native(path + ext)
    pou = trueFind(creationObject, name)
    if pou:
        loopDir(pou, pou, path, False)


###########################################################################################################################################
# Members
def handleProperty(creationObject, placementObject, name, path, ext):
    pou = creationObject.create_property(name, 'INT')
    if placementObject:
        pou.move(placementObject, -1)
    parts = fileContent(path + ext).split('\n', 1)
    applyObjectBuildProperties(pou, json.loads(parts[0]), True)
    parts = parts[1].split('!__GETTER__!', 1)
    pou.textual_declaration.replace(parts[0][:-1])
    parts = parts[1].split('!__SETTER__!', 1)
    getter = pou.find('Get')[0]
    if len(parts[0]) > 2:
        getparts = parts[0].split('!__IMPLEMENTATION__!', 1)
        getter.textual_declaration.replace(getparts[0][1:-1])
        if getter.has_textual_implementation:
            getter.textual_implementation.append(getparts[1][1:-1])
    else:
        getter.remove()
    setter = pou.find('Set')[0]
    if len(parts[1]) > 1:
        setparts = parts[1].split('!__IMPLEMENTATION__!', 1)
        setter.textual_declaration.replace(setparts[0][1:-1])
        if setter.has_textual_implementation:
            setter.textual_implementation.append(setparts[1][1:])
    else:
        setter.remove()


def handleAction(creationObject, placementObject, name, path, ext):
    pou = creationObject.create_action(name)
    parts = fileContent(path + ext).split('\n', 1)
    applyObjectBuildProperties(pou, json.loads(parts[0]), True)
    if placementObject:
        pou.move(placementObject)
    pou.textual_implementation.replace(parts[1])


def handleMethod(creationObject, placementObject, name, path, ext):
    pou = creationObject.create_method(name)
    if placementObject:
        pou.move(placementObject)
    writeDeclerationAndImplementationToObject(pou, fileContent(path + ext), True)


def handleTransition(creationObject, placementObject, name, path, ext):
    pou = creationObject.create_transition(name)
    parts = fileContent(path + ext).split('\n', 1)
    applyObjectBuildProperties(pou, json.loads(parts[0]), True)
    if placementObject:
        pou.move(placementObject)
    pou.textual_implementation.replace(parts[1])


###########################################################################################################################################
# Specials
def handleTextList(creationObject, name, path, ext, isGlobal):
    print('handleTextList->creationObject, name, path, ext, isGlobal', creationObject, name, path, ext, isGlobal)
    loaded = fileContent(path + ext)
    print('handleTextList->loaded', loaded)
    textListJson = json.loads(loaded)
    if isGlobal:
        typeGUID = "63784cbb-9ba0-45e6-9d69-babf3f040511"
    else:
        typeGUID = "2bef0454-1bd3-412a-ac2c-af0f31dbc40f"
    textList = """"""
    for textItem in textListJson["TextList"]:
        languages = """<List Name="LanguageTexts" Type="System.Collections.ArrayList">"""
        for langItems in textItem["LanguageTexts"]:
            languages = languages + """<Single Type="string">""" + langItems + """</Single>"""
        textList = textList + """<Single Type="{53da1be7-ad25-47c3-b0e8-e26286dad2e0}" Method="IArchivable"><Single Name="TextID" Type="string">""" + str(
            textItem["TextID"]) + """</Single><Single Name="TextDefault" Type="string">""" + textItem["TextDefault"] + """</Single>""" + languages + """</List></Single>"""
    languageList = ''
    for langItems in textListJson["LanguageList"]:
        languageList = languageList + """<Single Type="string">""" + langItems + """</Single>"""
    extData = """<ExportFile><StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}"><Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable"><Null Name="Profile" /><List2 Name="EntryList"><Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">94219ed4-c5bd-4d8b-af4f-4e345d98c65d</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + name + """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">""" + typeGUID + \
        """</Single><Array Name="EmbeddedTypeGuids" Type="System.Guid" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{""" + typeGUID + """}" Method="IArchivable"><Single Name="UniqueIdGenerator" Type="string">0</Single><List Name="TextList" Type="System.Collections.ArrayList">""" + textList + """</List><List Name="Languages" Type="System.Collections.ArrayList">""" + languageList + """</List><Single Name="GuidInit" Type="System.Guid">5b0e1823-2581-4969-a09b-b5fab15da65a</Single><Single Name="GuidReInit" Type="System.Guid">ab41cbd1-b3fd-4a03-a7f2-7e9c62eaa18b</Single><Single Name="GuidExitX" Type="System.Guid">ab21c0f1-2032-4360-bbfd-2e5e86925933</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single></List2><Null Name="ProfileName" /></Single></StructuredView></ExportFile>"""
    writeTempFile(extData)
    creationObject.import_native(tempFilePath)


def handleImagePool(creationObject, name, path, ext):
    jsonData = json.loads(fileContent(path + ext))
    extData = """<ExportFile><StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}"><Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable"><Null Name="Profile" /><List2 Name="EntryList"><Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">f46998ba-2626-4ec2-9a83-574e14c52f23</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + \
        name + """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">bb0b9044-714e-4614-ad3e-33cbdf34d16b</Single><Null Name="EmbeddedTypeGuids" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{bb0b9044-714e-4614-ad3e-33cbdf34d16b}" Method="IArchivable"><Single Name="UniqueIdGenerator" Type="string">10</Single><List Name="BitmapPool" Type="System.Collections.ArrayList">"""
    for image in jsonData["imagepool"]:
        extData = extData + """<Single Type="{215b2719-0347-4e4d-ba85-8bcd66946f66}" Method="IArchivable"><Single Name="BitmapID" Type="string">""" + \
            image['id'] + """</Single><Single Name="FileID" Type="string">""" + image['fileID'] + """</Single><Single Name="ItemID" Type="int">""" + image['itemID'] + """</Single></Single>"""
    extData = extData + """</List><Single Name="GuidInit" Type="System.Guid">3e93a304-a5a8-4916-a921-3b0c3cf5c871</Single><Single Name="GuidReInit" Type="System.Guid">5a972ab1-fda5-44df-b529-8b164710d226</Single><Single Name="GuidExitX" Type="System.Guid">76be1e53-b9b5-43b7-b99c-51b7a1509208</Single><Single Name="ValidIds" Type="bool">True</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single>"""
    for image in jsonData["imagedata"]:
        extData = extData + """<Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">""" + image['guid'] + """</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + image['name'] + """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">9001d745-b9c5-4d77-90b7-b29c3f77a23b</Single><Null Name="EmbeddedTypeGuids" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{9001d745-b9c5-4d77-90b7-b29c3f77a23b}" Method="IArchivable"><Single Name="AutoUpdateMode" Type="string">""" + image[
            'autoUpdateMode'] + """</Single><Array Name="Data" Type="byte">""" + image['data'] + """</Array><Single Name="LastModification" Type="System.DateTime">01/01/2000 01:01:01</Single><Single Name="Frozen" Type="bool">""" + image['frozen'] + """</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single>"""
    extData = extData + """</List2><Null Name="ProfileName" /></Single></StructuredView></ExportFile>"""
    writeTempFile(extData)
    creationObject.import_native(tempFilePath)


def handleProjectSettings(creationObject, path, ext):
    creationObject.import_native(path + ext)


def handleLibraryManager(creationObject, path, ext):
    manager = creationObject.get_library_manager()
    jsonData = json.loads(fileContent(path + ext))
    for library in jsonData["libraries"]:
        if not library["system_library"]:
            lib = librarymanager.find_library(library["name"])
            if lib:
                manager.add_library(lib[0])
    for placeholder in jsonData["placeholders"]:
        if not placeholder["system_library"]:
            if len(placeholder["default_resolution"]):
                lib = librarymanager.find_library(placeholder["default_resolution"])
            else:
                lib = librarymanager.find_library(placeholder["effective_resolution"])
            if lib:
                manager.add_placeholder(placeholder["namespace"], lib[0])
    applyObjectBuildProperties(manager, jsonData["BuildProperties"], False)


###########################################################################################################################################
# Visu
def handleVisu(creationObject, path, ext):
    creationObject.import_native(path + ext)


def handleVisuManager(creationObject, name, path, ext):
    creationObject.import_native(path + ext)


###########################################################################################################################################
# PLC
plclist = []


def handlePLC(name, path, ext):
    jsonData = json.loads(fileContent(path + ext))
    deviceTypes = e_device_catalog.find_device_type(jsonData["ordernumber"], jsonData["version"])
    plc = project.add_device(deviceTypes[0], 1)[0]
    plclist.append({"plc": plc, "name": name})
    plc.ip_address = jsonData["ipaddress"]
    for index, module in enumerate(jsonData["modules"]):
        type = e_device_catalog.find_device_type(module["ordernumber"], module["version"])
        plc.add_module(type[0], index, 1)
    plc.import_io_mappings_from_csv(os.path.join(path, '%KBUS%Kbus.csv'))
    loopDir(plc, None, path, False)


def plcRename():
    time.sleep(2)
    for plc in plclist:
        plc['plc'].rename(plc["name"])


def handlePLCLogic(creationObject,  name, path, ext):
    creationObject.import_native(path + ext)
    self = trueFind(creationObject, name)
    if self:
        loopDir(self, None, path, False)


def handleApplication(creationObject,  name, path):
    device = trueFindDevice(creationObject.parent.get_name())
    project.import_app_native([device.device_guid], path + '.xml')
    app = trueFind(creationObject, name)
    loopDir(app, None, path, True)


def handleTaskConfiguration(creationObject,  name, path):
    creationObject.import_native(path + '.xml')
    obj = trueFind(creationObject, name)
    if obj:
        loopDir(obj, None, path, False)


def handleTask(creationObject, path):
    creationObject.import_native(path + '.xml')

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Loopers


def handleFile(creationObject, placementObject, path, file):
    search = re.search("%.+%", file)
    type = search.group()
    split = os.path.splitext(file[search.span()[1]:])
    objectname = decodeObjectName(split[0])
    ext = split[1]
    path = os.path.join(path, type + split[0])
    if type == '%F%' and ext == '.json':
        handleFolder(creationObject, placementObject, objectname, path, ext)
    # Normals
    elif type == '%POU%' and ext == '.st':
        handlePOU(creationObject, objectname, path, ext)
    elif type == '%DUT%' and ext == '.st':
        handleDUT(creationObject, objectname, path, ext)
    elif type == '%GVL%' and ext == '.st':
        handleGVL(creationObject, objectname, path, ext)
    elif type == '%ITF%' and ext == '.st':
        handleInterface(creationObject, objectname, path, ext)
    elif type == '%PV%' and ext == '.xml':
        handlePersistentVariables(creationObject, objectname, path, ext)
    # Members
    elif type == '%PRO%' and ext == '.st':
        handleProperty(creationObject, placementObject, objectname, path, ext)
    elif type == '%ACT%' and ext == '.st':
        handleAction(creationObject, placementObject, objectname, path, ext)
    elif type == '%METH%' and ext == '.st':
        handleMethod(creationObject, placementObject, objectname, path, ext)
    elif type == '%TRAN%' and ext == '.st':
        handleTransition(creationObject, placementObject, objectname, path, ext)
    # Specials
    elif type == '%TL%' and ext == '.json':  # Text List
        handleTextList(creationObject,  objectname, path, ext, False)
    elif type == '%GTL%' and ext == '.json':  # Global Text List
        handleTextList(creationObject,  objectname, path, ext, True)
    elif type == '%IMP%' and ext == '.json':  # Image Pool
        handleImagePool(creationObject, objectname, path, ext)
    elif type == '%PS%' and ext == '.xml':  # Project Settings
        handleProjectSettings(creationObject,  path, ext)
    elif type == '%LIB%' and ext == '.json':  # Library Manager
        handleLibraryManager(creationObject, path, ext)
    # Visu
    elif type == '%VISU%' and ext == '.xml':
        handleVisu(creationObject,  path, ext)
    elif type == '%VIMA%' and ext == '.xml':
        handleVisuManager(creationObject, objectname, path, ext)
    elif type == '%WV%' and ext == '.xml':
        handleWebVisu(creationObject, path, ext)
    # PLC
    elif type == '%PLC%' and ext == '.json':
        handlePLC(objectname, path, ext)
    elif type == '%PLOG%' and ext == '.xml':
        handlePLCLogic(creationObject, objectname, path, ext)
    elif type == '%APP%' and ext == '.xml':
        handleApplication(creationObject, objectname, path)
    elif type == '%TC%' and ext == '.xml':
        handleTaskConfiguration(creationObject,  objectname, path)
    elif type == '%TSK%' and ext == '.xml':
        handleTask(creationObject,  path)


objectOrder = ['%LIB%Library Manager.json', '%GTL%GlobalTextList.json', '%TC%Task configuration.xml', '%VIMA%Visualization Manager.xml']


def loopDir(creationObject, placementObject, path, sort):
    if os.path.exists(path):
        for root, dirs, files in os.walk(path):
            if sort:
                ordered = [element for element in objectOrder if element in files]
                ordered.extend(y for y in files if y not in ordered)
                files = ordered
            for file in files:
                handleFile(creationObject, placementObject, path, file)
            break


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

# Creates project and gets reference to project object
project = e_projects.create_new_project()
project.create_folder('_creationfolder_')
creationfolder = project.find('_creationfolder_')[0]
projectObject = creationfolder.parent
creationfolder.remove()


# Loops files in src directory
loopDir(projectObject, None, os.path.join(sys.argv[1], "src"), True)
plcRename()
finishedDefferedEnable()

# Cleanup
if os.path.exists(tempFilePath):
    os.remove(tempFilePath)

# Save Project
project.save_as(os.path.join(sys.argv[1], 'ecp', "src.ecp"))

# Close project
e_system.close_e_cockpit()
