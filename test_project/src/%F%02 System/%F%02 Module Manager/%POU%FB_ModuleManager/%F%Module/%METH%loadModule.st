{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This load the module from file
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-01-21 | Creation
METHOD loadModule : SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR
!__IMPLEMENTATION__!
//Check if the module is allowed to load data
GMod.modMan.incrementUpdateNumber();
loadModule		:=		S_loadSaver.LSStart(sFilePath:=getPath(module:=module,dirPath:=FALSE),xReadWrite:=FALSE,dontLog:=TRUE);
IF loadModule.success THEN
	IF S_loadSaver.findKey(name:=GTSmall.Suid) = EStructType.number THEN
		module^._UID		:=		TO_WORD(S_loadSaver.readDint());
	END_IF
	IF S_loadSaver.findKey(name:=GTSmall.SsubID) <> EStructType.none THEN
		module^._SID		:=		TO_WORD(S_loadSaver.readDint());
	END_IF
	IF module^.SYS_nameWrite THEN
		IF S_loadSaver.findKey(name:=GTSmall.Sname) = EStructType.tString THEN
			setModuleNameStruct(module:=module,reader:=S_loadSaver);
		END_IF
	END_IF
	IF module^.SYS_unitWrite THEN
		IF S_loadSaver.findKey(name:=GTSmall.Sunit) = EStructType.tString THEN
			setModuleUnitFromStruct(module:=module,reader:=S_loadSaver);
		END_IF
	END_IF
	S_loadSaver.findKey(name:=GTSmall.Sparams);
	S_loadSaver.enterObjectArray();
	loadModule					:=		module^.SYS_loadData(loader:=S_loadSaver);
	S_loadSaver.exitObjectArray();	
END_IF
S_loadSaver.LSEnd();
module^.SYS_loadDataExt(loadSaver:=S_loadSaver);
