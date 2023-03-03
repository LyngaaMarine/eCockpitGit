{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": true, "enable_system_call": false}
//This method is called by the management task to change configuration of the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-02-22 | Creation
METHOD changeModuleConfig : SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
	client			:POINTER TO FB_DataServerClient;
	reader			:ITF_StructReaderBase;
	duringCreation	:BOOL;		//Is set true during creation of module
END_VAR
!__IMPLEMENTATION__!
IF reader.findKey(name:=GTSmall.Sname) <> EStructType.none THEN
	changeModuleConfig			:=		setModuleNameStruct(module:=module,reader:=reader);
END_IF
IF changeModuleConfig.success THEN
	IF reader.findKey(name:=GTSmall.Sunit) <> EStructType.none THEN
		changeModuleConfig		:=		setModuleUnitFromStruct(module:=module,reader:=reader);
	END_IF
	IF changeModuleConfig.success THEN
		changeModuleConfig		:=		module^.SYS_changeConfig(reader:=reader,client:=client,duringCreation:=duringCreation);
	END_IF
END_IF
