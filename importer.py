# We enable the new python 3 print syntax
from __future__ import print_function
import sys
import os
import re
import json

# Creates project and gets reference to project object
project = e_projects.create_new_project()
project.create_folder('_creationfolder_')
creationfolder = project.find('_creationfolder_')[0]
projectObject = creationfolder.parent
creationfolder.remove()


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


# Normals
def handlePOU(object, data, name):
    pou = object.create_pou(name, PouType.Program)
    writeDeclerationAndImplementationToObject(pou, data)


def handleDUT(object, data, name):
    pou = object.create_dut(name, DutType.Structure)
    pou.textual_declaration.replace(data)


def handleGVL(object, data, name):
    pou = object.create_gvl(name)
    pou.textual_declaration.replace(data)


def handleInterface(object, data, name):
    pou = object.create_interface(name)
    pou.textual_declaration.replace(data)


# Members
def handleProperty(object, data, name, noneFolderObject, path):
    tryPrintObjectName('handleProperty->object', object)
    print('handleProperty->name', name)
    if noneFolderObject != False:
        tryPrintObjectName('handleProperty->noneFolderObject', noneFolderObject)
    if noneFolderObject:
        pou = noneFolderObject.create_property(name, 'INT')
        pou.move(object, -1)
    else:
        pou = object.create_property(name, 'INT')
    pou.textual_declaration.replace(data)
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


def handleAction(object, data, name, noneFolderObject):
    if noneFolderObject:
        pou = noneFolderObject.create_action(name)
        pou.move(object)
    else:
        pou = object.create_action(name)
    pou.textual_implementation.replace(data)


def handleMethod(object, data, name, noneFolderObject):
    if noneFolderObject:
        pou = noneFolderObject.create_method(name)
        pou.move(object)
    else:
        pou = object.create_method(name)
    writeDeclerationAndImplementationToObject(pou, data)


def handleTransition(object, data, name, noneFolderObject):
    if noneFolderObject:
        pou = noneFolderObject.create_transition(name)
        pou.move(object)
    else:
        pou = object.create_transition(name)
    pou.textual_implementation.replace(data)


def handleFile(object, path, file, noneFolderObject):
    search = re.search("%.+%", file)
    type = search.group()
    split = os.path.splitext(file[search.span()[1]:])
    name = split[0]
    ext = split[1]
    newPath = os.path.join(path, file)
    data = fileContent(newPath)
    print('handleFile->name/type/path', name, type, path)
    tryPrintObjectName('handleFile->object', object)
    if noneFolderObject != False:
        tryPrintObjectName('handleFile->noneFolderObject', noneFolderObject)
    # Normals
    if type == '%POU%' and ext == '.st':
        handlePOU(object, data, name)
    elif type == '%DUT%' and ext == '.st':
        handleDUT(object, data, name)
    elif type == '%GVL%' and ext == '.st':
        handleGVL(object, data, name)
    elif type == '%ITF%' and ext == '.st':
        handleInterface(object, data, name)
    # Members
    elif type == '%PRO%' and ext == '.st':
        handleProperty(object, data, name, noneFolderObject, newPath[:-3])
    elif type == '%ACT%' and ext == '.st':
        handleAction(object, data, name, noneFolderObject)
    elif type == '%METH%' and ext == '.st':
        handleMethod(object, data, name, noneFolderObject)
    elif type == '%TRAN%' and ext == '.st':
        handleTransition(object, data, name, noneFolderObject)
    # PLC
    elif type == '%PLC%' and ext == '.json':
        print()
    # Specials
    elif type == '%EF%' and ext == '.txt':  # External File
        handleExternalFile(object, data, name)
    elif type == '%TL%' and ext == '.json':  # Text List
        handleTextList(object, data, name, False)
    elif type == '%GTL%' and ext == '.json':  # Global Text List
        handleTextList(object, data, name, True)
    elif type == '%PS%' and ext == '.xml':  # Global Text List
        handleTextList(object, data, name, True)

    else:
        print('Unknown ' + file + ' ' + path)


def handleDir(object, path, dir, noneFolderObject):
    tryPrintObjectName('handleDir->object', object)
    newPath = os.path.join(path, dir)
    search = re.search("%.+%", dir)
    type = search.group()
    name = dir[search.span()[1]:]
    print('handleDir->name/type/path', name, type, path)
    if type == '%F%':
        print('handleDir->folderiscreated')
        object.create_folder(name)
        find = object.find(name)
        print('handleDir->find', find)
        print('handleDir->findlen', len(find))
        print('handleDir->findfirst', find[0])
        if len(find) > 0 and find[0]:
            print('handleDir->nonefolderischecked')
            if not noneFolderObject:
                if checkIsTypeWhoCanHaveFolderAndMember(object):
                    noneFolderObject = object
                else:
                    noneFolderObject = False

            tryPrintObjectName('handleDir->folder->find[0]', find[0])
            tryPrintObjectName('handleDir->folder->noneFolderObject', noneFolderObject)
            loopDir(find[0], newPath, noneFolderObject)
    else:
        find = object.find(name)
        if len(find) > 0 and find[0]:
            tryPrintObjectName('handleDir->other->find[0]', find[0])
            loopDir(find[0], newPath, False)


def loopDir(object, path, noneFolderObject):
    print('loopDir->path', path)
    for root, dirs, files in os.walk(path):
        for file in files:
            handleFile(object, path, file, noneFolderObject)
        for dir in dirs:
            handleDir(object, path, dir, noneFolderObject)
        break


def handleExternalFile(object, data, name):
    extData = """<ExportFile>
<StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}">
<Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable">
  <Null Name="Profile" />
  <List2 Name="EntryList">
    <Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable">
      <Single Name="IsRoot" Type="bool">True</Single>
      <Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable">
        <Single Name="Guid" Type="System.Guid">fa9ab52e-878c-4f0a-a8df-974f770d9d0f</Single>
        <Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single>
        <Single Name="Name" Type="string">""" + name + """</Single>
        <Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" />
        <Single Name="TypeGuid" Type="System.Guid">a56744ff-693f-4597-95f9-0e1c529fffc2</Single>
        <Null Name="EmbeddedTypeGuids" />
        <Single Name="Timestamp" Type="long">0</Single>
      </Single>
      <Single Name="Object" Type="{a56744ff-693f-4597-95f9-0e1c529fffc2}" Method="IArchivable">
        <Single Name="FileId" Type="string">00000000-0000-0000-0000-000000000000|""" + data + """</Single>
      </Single>
      <Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single>
      <Array Name="Path" Type="string" />
      <Single Name="Index" Type="int">-1</Single>
    </Single>
  </List2>
  <Null Name="ProfileName" />
</Single>  </StructuredView>
</ExportFile>"""
    writeTempFile(extData)
    object.import_native(tempFilePath)


def handleTextList(object, data, name, isGlobal):
    textListJson = json.loads(data)
    if isGlobal:
        typeGUID = "63784cbb-9ba0-45e6-9d69-babf3f040511"
    else:
        typeGUID = "2bef0454-1bd3-412a-ac2c-af0f31dbc40f"

    textList = """"""
    for textItem in textListJson["TextList"]:
        languages = """<List Name="LanguageTexts" Type="System.Collections.ArrayList">"""
        for langItems in textItem["LanguageTexts"]:
            languages = languages + """
                            <Single Type="string">""" + langItems + """</Single>"""
        languages = languages + """
                        </List>"""

        textList = textList + """
                    <Single Type="{53da1be7-ad25-47c3-b0e8-e26286dad2e0}" Method="IArchivable">
                        <Single Name="TextID" Type="string">""" + str(textItem["TextID"]) + """</Single>
                        <Single Name="TextDefault" Type="string">""" + textItem["TextDefault"] + """</Single>
                        """ + languages + """
                    </Single>"""

    languageList = ''
    for langItems in textListJson["LanguageList"]:
        languageList = languageList + """
                    <Single Type="string">""" + langItems + """</Single>"""

    extData = """<ExportFile>
    <StructuredView Guid="{21af5390-2942-461a-bf89-951aaf6999f1}">
<Single xml:space="preserve" Type="{3daac5e4-660e-42e4-9cea-3711b98bfb63}" Method="IArchivable">
    <Null Name="Profile" />
    <List2 Name="EntryList">
        <Single Type="{6198ad31-4b98-445c-927f-3258a0e82fe3}" Method="IArchivable">
            <Single Name="IsRoot" Type="bool">True</Single>
            <Single Name="MetaObject" Type="{81297157-7ec9-45ce-845e-84cab2b88ade}" Method="IArchivable">
                <Single Name="Guid" Type="System.Guid">94219ed4-c5bd-4d8b-af4f-4e345d98c65d</Single>
                <Single Name="ParentGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single>
                <Single Name="Name" Type="string">""" + name + """</Single>
                <Dictionary Type="{2c41fa04-1834-41c1-816e-303c7aa2c05b}" Name="Properties" />
                <Single Name="TypeGuid" Type="System.Guid">""" + typeGUID + """</Single>
                <Array Name="EmbeddedTypeGuids" Type="System.Guid" />
                <Single Name="Timestamp" Type="long">0</Single>
            </Single>
            <Single Name="Object" Type="{""" + typeGUID + """}" Method="IArchivable">
                <Single Name="UniqueIdGenerator" Type="string">0</Single>
                <List Name="TextList" Type="System.Collections.ArrayList">""" + textList + """
                </List>
                <List Name="Languages" Type="System.Collections.ArrayList">""" + languageList + """
                </List>
                <Single Name="GuidInit" Type="System.Guid">5b0e1823-2581-4969-a09b-b5fab15da65a</Single>
                <Single Name="GuidReInit" Type="System.Guid">ab41cbd1-b3fd-4a03-a7f2-7e9c62eaa18b</Single>
                <Single Name="GuidExitX" Type="System.Guid">ab21c0f1-2032-4360-bbfd-2e5e86925933</Single>
            </Single>
            <Single Name="ParentSVNodeGuid" Type="System.Guid">00000000-0000-0000-0000-000000000000</Single>
            <Array Name="Path" Type="string" />
            <Single Name="Index" Type="int">-1</Single>
        </Single>
    </List2>
    <Null Name="ProfileName" />
</Single></StructuredView>
</ExportFile>"""
    writeTempFile(extData)
    object.import_native(tempFilePath)


########################################################################################################
########################################################################################################
########################################################################################################
# Starts script and cleanup
loopDir(projectObject, os.path.join(sys.argv[1], "src"), False)

#project.save_as(os.path.join(sys.argv[1], 'ecp', "src.ecp"))

# e_system.close_e_cockpit()

if os.path.exists(tempFilePath):
    os.remove(tempFilePath)
