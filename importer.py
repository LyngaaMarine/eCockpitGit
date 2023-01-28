# We enable the new python 3 print syntax
from __future__ import print_function
import sys
import os
import re
import json
import time
import shutil

# Creates project and gets reference to project object
project = e_projects.create_new_project()
project.create_folder('_creationfolder_')
creationfolder = project.find('_creationfolder_')[0]
projectObject = creationfolder.parent
creationfolder.remove()

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Helpers


def tryPrintObjectName(text, obj):
    try:
        print(text, obj.get_name())
    except:
        print(text, 'none/root')


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


libs = librarymanager.get_all_libraries(False)


def trueFindLib(name, vers, rep):
    if vers == '*':
        founds = []
        for lib in libs:
            if lib.title == name:
                founds.append(lib)
        theLib = None
        ver1 = 0
        ver2 = 0
        ver3 = 0
        ver4 = 0
        for lib in founds:
            search = re.search(r"(\d+)\.(\d+)\.(\d+)\.(\d+)", str(lib.version))
            v1 = int(search.group(1))
            if v1 > ver1:
                theLib = lib
                ver1 = v1
            elif v1 == ver1:
                v2 = int(search.group(2))
                if v2 > ver2:
                    theLib = lib
                    ver2 = v2
                elif v2 == ver2:
                    v3 = int(search.group(3))
                    if v3 > ver3:
                        theLib = lib
                        ver3 = v3
                    elif v3 == ver3:
                        v4 = int(search.group(4))
                        if v4 > ver4:
                            theLib = lib
                            ver4 = v4
        return theLib
    else:
        for lib in libs:
            if lib.title == name and lib.version == vers:
                return lib


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
    f = open(path, 'r')
    data = f.read()
    f.close()
    return data


tempFilePath = os.path.join(sys.argv[1], "tempFile")


def writeTempFile(data):
    f = open(tempFilePath, 'w')
    f.write(data)
    f.close()


def writeDeclerationAndImplementationToObject(object, data):
    search = re.search("(\*%!%__DELIMITER__%!%\*)", data)
    declaration = data[:search.span()[0]-2]
    implementation = data[search.span()[1] + 2:]
    object.textual_declaration.replace(declaration)
    if object.has_textual_implementation:
        object.textual_implementation.append(implementation)

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Handlers


def handleFolder(creationObject, placementObject, name, path):
    print('handleFolder->name/path', name, path)
    creationObject.create_folder(name)
    if placementObject:
        self = trueFind(placementObject, name)
    else:
        self = trueFind(creationObject, name)
    if self:
        if creationObject == placementObject:
            loopDir(creationObject, self, path)
        else:
            loopDir(self, None, path)


###########################################################################################################################################
# Normals
def handlePOU(creationObject, name, path, ext):
    print('handlePOU->name/path/ext', name, path, ext)
    pou = creationObject.create_pou(name, PouType.Program)
    writeDeclerationAndImplementationToObject(pou, fileContent(path + ext))
    loopDir(pou, pou, path)


def handleDUT(creationObject, name, path, ext):
    print('handleDUT->name/path/ext', name, path, ext)
    pou = creationObject.create_dut(name, DutType.Structure)
    pou.textual_declaration.replace(fileContent(path + ext))
    loopDir(pou, pou, path)


def handleGVL(creationObject, name, path, ext):
    print('handleGVL->name/path/ext', name, path, ext)
    pou = creationObject.create_gvl(name)
    pou.textual_declaration.replace(fileContent(path + ext))
    loopDir(pou, pou, path)


def handleInterface(creationObject, name, path, ext):
    print('handleInterface->name/path/ext', name, path, ext)
    pou = creationObject.create_interface(name)
    pou.textual_declaration.replace(fileContent(path + ext))
    loopDir(pou, pou, path)


def handlePersistentVariables(creationObject, name, path, ext):
    print('handlePersistentVariables->name,path,ext', name, path, ext)
    creationObject.import_native(path + ext)
    pou = trueFind(creationObject, name)
    if pou:
        loopDir(pou, pou, path)


###########################################################################################################################################
# Members
def handleProperty(creationObject, placementObject, name, path, ext):
    print('handleProperty->name,path,ext', name, path, ext)
    pou = creationObject.create_property(name, 'INT')
    if placementObject:
        pou.move(placementObject, -1)
    pou.textual_declaration.replace(fileContent(path + ext))
    getter = pou.find('Get')[0]
    getterPath = os.path.join(path, '%GETSET%Get.st')
    if os.path.exists(getterPath):
        getData = fileContent(getterPath)
        writeDeclerationAndImplementationToObject(getter, getData)
        print('handleProperty->hasGetter')
    else:
        getter.remove()
    setter = pou.find('Set')[0]
    setterPath = os.path.join(path, '%GETSET%Set.st')
    if os.path.exists(setterPath):
        print('handleProperty->hasSetter')
        setData = fileContent(setterPath)
        writeDeclerationAndImplementationToObject(setter, setData)
    else:
        setter.remove()


def handleAction(creationObject, placementObject, name, path, ext):
    print('handleAction->name,path,ext', name, path, ext)
    pou = creationObject.create_action(name)
    if placementObject:
        pou.move(placementObject)
    pou.textual_implementation.replace(fileContent(path + ext))


def handleMethod(creationObject, placementObject, name, path, ext):
    print('handleMethod->name,path,ext', name, path, ext)
    pou = creationObject.create_method(name)
    if placementObject:
        pou.move(placementObject)
    writeDeclerationAndImplementationToObject(pou, fileContent(path + ext))


def handleTransition(creationObject, placementObject, name, path, ext):
    print('handleTransition->name,path,ext', name, path, ext)
    pou = creationObject.create_transition(name)
    if placementObject:
        pou.move(placementObject)
    pou.textual_implementation.replace(fileContent(path + ext))


###########################################################################################################################################
# Specials
def handleExternalFile(creationObject, placementObject, name, path, ext):
    print('handleExternalFile->name,path,ext', name, path, ext)
    extData = """<ExportFile><StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}"><Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable"><Null Name="Profile" /><List2 Name="EntryList"><Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">fa9ab52e-878c-4f0a-a8df-974f770d9d0f</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + name + \
        """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">a56744ff-693f-4597-95f9-0e1c529fffc2</Single><Null Name="EmbeddedTypeGuids" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{a56744ff-693f-4597-95f9-0e1c529fffc2}" Method="IArchivable"><Single Name="FileId" Type="string">00000000-0000-0000-0000-000000000000|""" + fileContent(path + ext) + """</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single></List2><Null Name="ProfileName" /></Single></StructuredView></ExportFile>"""
    writeTempFile(extData)
    creationObject.import_native(tempFilePath)


def handleTextList(creationObject, placementObject, name, path, ext, isGlobal):
    print('handleTextList->name,path,ext', name, path, ext)
    textListJson = json.loads(fileContent(path + ext))
    if isGlobal:
        typeGUID = "63784cbb-9ba0-45e6-9d69-babf3f040511"
    else:
        typeGUID = "2bef0454-1bd3-412a-ac2c-af0f31dbc40f"
    textList = """"""
    for textItem in textListJson["TextList"]:
        languages = """<List Name="LanguageTexts" Type="System.Collections.ArrayList">"""
        for langItems in textItem["LanguageTexts"]:
            languages = languages + """<Single Type="string">""" + langItems + """</Single>"""
        textList = textList + """<Single Type="{53da1be7-ad25-47c3-b0e8-e26286dad2e0}" Method="IArchivable"><Single Name="TextID" Type="string">""" + str(textItem["TextID"]) + """</Single><Single Name="TextDefault" Type="string">""" + textItem["TextDefault"] + """</Single>""" + languages + """</List></Single>"""
    languageList = ''
    for langItems in textListJson["LanguageList"]:
        languageList = languageList + """<Single Type="string">""" + langItems + """</Single>"""
    extData = """<ExportFile><StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}"><Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable"><Null Name="Profile" /><List2 Name="EntryList"><Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">94219ed4-c5bd-4d8b-af4f-4e345d98c65d</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + name + """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">""" + typeGUID + \
        """</Single><Array Name="EmbeddedTypeGuids" Type="System.Guid" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{""" + typeGUID + """}" Method="IArchivable"><Single Name="UniqueIdGenerator" Type="string">0</Single><List Name="TextList" Type="System.Collections.ArrayList">""" + textList + """</List><List Name="Languages" Type="System.Collections.ArrayList">""" + languageList + """</List><Single Name="GuidInit" Type="System.Guid">5b0e1823-2581-4969-a09b-b5fab15da65a</Single><Single Name="GuidReInit" Type="System.Guid">ab41cbd1-b3fd-4a03-a7f2-7e9c62eaa18b</Single><Single Name="GuidExitX" Type="System.Guid">ab21c0f1-2032-4360-bbfd-2e5e86925933</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single></List2><Null Name="ProfileName" /></Single></StructuredView></ExportFile>"""
    writeTempFile(extData)
    creationObject.import_native(tempFilePath)


def handleImagePool(creationObject, placementObject, name, path, ext):
    print('handleImagePool->name,path,ext', name, path, ext)
    jsonData = json.loads(fileContent(path + ext))
    extData = """<ExportFile><StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}"><Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable"><Null Name="Profile" /><List2 Name="EntryList"><Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">f46998ba-2626-4ec2-9a83-574e14c52f23</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + \
        name + """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">bb0b9044-714e-4614-ad3e-33cbdf34d16b</Single><Null Name="EmbeddedTypeGuids" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{bb0b9044-714e-4614-ad3e-33cbdf34d16b}" Method="IArchivable"><Single Name="UniqueIdGenerator" Type="string">10</Single><List Name="BitmapPool" Type="System.Collections.ArrayList">"""
    for image in jsonData["imagepool"]:
        extData = extData + """<Single Type="{215b2719-0347-4e4d-ba85-8bcd66946f66}" Method="IArchivable"><Single Name="BitmapID" Type="string">""" + image['id'] + """</Single><Single Name="FileID" Type="string">""" + image['fileID'] + """</Single><Single Name="ItemID" Type="int">""" + image['itemID'] + """</Single></Single>"""
    extData = extData + """</List><Single Name="GuidInit" Type="System.Guid">3e93a304-a5a8-4916-a921-3b0c3cf5c871</Single><Single Name="GuidReInit" Type="System.Guid">5a972ab1-fda5-44df-b529-8b164710d226</Single><Single Name="GuidExitX" Type="System.Guid">76be1e53-b9b5-43b7-b99c-51b7a1509208</Single><Single Name="ValidIds" Type="bool">True</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single>"""
    for image in jsonData["imagedata"]:
        extData = extData + """<Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable"><Single Name="IsRoot" Type="bool">True</Single><Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable"><Single Name="Guid" Type="System.Guid">""" + image['guid'] + """</Single><Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Single Name="Name" Type="string">""" + image['name'] + """</Single><Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" /><Single Name="TypeGuid" Type="System.Guid">9001d745-b9c5-4d77-90b7-b29c3f77a23b</Single><Null Name="EmbeddedTypeGuids" /><Single Name="Timestamp" Type="long">0</Single></Single><Single Name="Object" Type="{9001d745-b9c5-4d77-90b7-b29c3f77a23b}" Method="IArchivable"><Single Name="AutoUpdateMode" Type="string">""" + image[
            'autoUpdateMode'] + """</Single><Array Name="Data" Type="byte">""" + image['data'] + """</Array><Single Name="LastModification" Type="System.DateTime">01/01/2000 01:01:01</Single><Single Name="Frozen" Type="bool">""" + image['frozen'] + """</Single></Single><Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single><Array Name="Path" Type="string" /><Single Name="Index" Type="int">-1</Single></Single>"""
    extData = extData + """</List2><Null Name="ProfileName" /></Single></StructuredView></ExportFile>"""
    writeTempFile(extData)
    creationObject.import_native(tempFilePath)


def handleProjectSettings(creationObject, placementObject, name, path, ext):
    print('handleProjectSettings->name,path,ext', name, path, ext)
    creationObject.import_native(path + ext)


def handleLibraryManager(creationObject, placementObject, name, path, ext):
    print('handleLibraryManager->name,path,ext', name, path, ext)
    manager = creationObject.get_library_manager()
    jsonData = json.loads(fileContent(path + ext))
    for library in jsonData["libraries"]:
        lib = trueFindLib(library["name"], library["version"], library["repository"])
        print('handleLibraryManager->library', library["name"], library["version"], library["repository"], lib)
        if lib:
            manager.add_library(lib)

###########################################################################################################################################
# Visu


def handleVisu(creationObject, placementObject, name, path, ext):
    print('handleVisu->name,path,ext', name, path, ext)
    creationObject.import_native(path + ext)


def handleVisuManager(creationObject, placementObject, name, path, ext):
    print('handleVisuManager->name,path,ext', name, path, ext)
    creationObject.import_native(path + ext)


###########################################################################################################################################
# PLC
plclist = []


def handlePLC(creationObject, placementObject, name, path, ext):
    print('handlePLC->name,path,ext', name, path, ext)
    jsonData = json.loads(fileContent(path + ext))
    deviceTypes = e_device_catalog.find_device_type(jsonData["ordernumber"], jsonData["version"])
    plc = project.add_device(deviceTypes[0], 1)[0]
    plclist.append({"plc": plc, "name": name})
    plc.ip_address = jsonData["ipaddress"]
    for index, module in enumerate(jsonData["modules"]):
        type = e_device_catalog.find_device_type(module["ordernumber"], module["version"])
        plc.add_module(type[0], index, 1)
    plc.import_io_mappings_from_csv(os.path.join(path, '%KBUS%Kbus.csv'))
    loopDir(plc, None, path)


def plcRename():
    time.sleep(2)
    for plc in plclist:
        plc['plc'].rename(plc["name"])


def handlePLCLogic(creationObject, placementObject, name, path, ext):
    print('handlePLCLogic->name,path,ext', name, path, ext)
    creationObject.import_native(path + ext)
    self = trueFind(creationObject, name)
    if self:
        loopDir(self, None, path)


def handleApplication(creationObject, placementObject, name, path, ext):
    device = trueFindDevice(creationObject.parent.get_name())
    project.import_app_native([device.device_guid], path + '.xml')
    app = trueFind(creationObject, name)
    loopDir(app, None, path)


def handleTaskConfiguration(creationObject, placementObject, name, path, ext):
    creationObject.import_native(path + '.xml')
    obj = trueFind(creationObject, name)
    if obj:
        loopDir(obj, None, path)


def handleTask(creationObject, placementObject, name, path, ext):
    creationObject.import_native(path + '.xml')

###########################################################################################################################################
###########################################################################################################################################
###########################################################################################################################################
# Loopers


def handleFile(creationObject, placementObject, path, file):
    tryPrintObjectName('handleFile->creationObject', creationObject)
    tryPrintObjectName('handleFile->placementObject', placementObject)
    search = re.search("%.+%", file)
    type = search.group()
    split = os.path.splitext(file[search.span()[1]:])
    name = split[0]
    ext = split[1]
    path = os.path.join(path, type + name)
    if type == '%F%' and ext == '.txt':
        handleFolder(creationObject, placementObject, name, path)
    # Normals
    elif type == '%POU%' and ext == '.st':
        handlePOU(creationObject, name, path, ext)
    elif type == '%DUT%' and ext == '.st':
        handleDUT(creationObject, name, path, ext)
    elif type == '%GVL%' and ext == '.st':
        handleGVL(creationObject, name, path, ext)
    elif type == '%ITF%' and ext == '.st':
        handleInterface(creationObject, name, path, ext)
    elif type == '%PV%' and ext == '.xml':
        handlePersistentVariables(creationObject, name, path, ext)
    # Members
    elif type == '%PRO%' and ext == '.st':
        handleProperty(creationObject, placementObject, name, path, ext)
    elif type == '%ACT%' and ext == '.st':
        handleAction(creationObject, placementObject, name, path, ext)
    elif type == '%METH%' and ext == '.st':
        handleMethod(creationObject, placementObject, name, path, ext)
    elif type == '%TRAN%' and ext == '.st':
        handleTransition(creationObject, placementObject, name, path, ext)
    # Specials
    elif type == '%EF%' and ext == '.txt':  # External File
        handleExternalFile(creationObject, placementObject, name, path, ext)
    elif type == '%TL%' and ext == '.json':  # Text List
        handleTextList(creationObject, placementObject, name, path, ext, False)
    elif type == '%AGTL%' and ext == '.json':  # Global Text List
        handleTextList(creationObject, placementObject, name, path, ext, True)
    elif type == '%IMP%' and ext == '.json':  # Image Pool
        handleImagePool(creationObject, placementObject, name, path, ext)
    elif type == '%PS%' and ext == '.xml':  # Project Settings
        handleProjectSettings(creationObject, placementObject, name, path, ext)
    elif type == '%ALIB%' and ext == '.json':  # Library Manager
        handleLibraryManager(creationObject, placementObject, name, path, ext)
    # Visu
    elif type == '%VISU%' and ext == '.xml':
        handleVisu(creationObject, placementObject, name, path, ext)
    elif type == '%VIMA%' and ext == '.xml':
        handleVisuManager(creationObject, placementObject, name, path, ext)
    # PLC
    elif type == '%PLC%' and ext == '.json':
        handlePLC(creationObject, placementObject, name, path, ext)
    elif type == '%PLOG%' and ext == '.xml':
        handlePLCLogic(creationObject, placementObject, name, path, ext)
    elif type == '%APP%' and ext == '.xml':
        handleApplication(creationObject, placementObject, name, path, ext)
    elif type == '%TC%' and ext == '.xml':
        handleTaskConfiguration(creationObject, placementObject, name, path, ext)
    elif type == '%TSK%' and ext == '.xml':
        handleTask(creationObject, placementObject, name, path, ext)
    # Unknowns
    else:
        print('Unknown ' + file + ' ' + path)


def loopDir(creationObject, placementObject, path):
    print('loopDir->path', path)
    if os.path.exists(path):
        print('loopDir->looping path')
        for root, dirs, files in os.walk(path):
            for file in files:
                handleFile(creationObject, placementObject, path, file)
            break


########################################################################################################
########################################################################################################
########################################################################################################
# Starts script and cleanup
loopDir(projectObject, None, os.path.join(sys.argv[1], "src"))
plcRename()
project.save_as(os.path.join(sys.argv[1], 'ecp', "src.ecp"))
shutil.copyfile(os.path.join(sys.argv[1], 'ecp', "src.ecp"), os.path.join(sys.argv[1], 'ecp_at_import', "src.ecp"))
e_system.close_e_cockpit()

if os.path.exists(tempFilePath):
    os.remove(tempFilePath)
