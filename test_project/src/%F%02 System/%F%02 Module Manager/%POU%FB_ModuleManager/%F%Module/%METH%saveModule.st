//This method moves an module from one parent to another
//Returns invalid id if id is invalid
//Returns varswrong if new parent id does not exist or is zero
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-06-19 | Creation
METHOD saveModule
VAR_INPUT
	module			:POINTER TO FB_Module;
	dontLog			:BOOL;			//If logging should be skipped
END_VAR

(*%!%__DELIMITER__%!%*)
IF module = 0 THEN
	RETURN;
END_IF
//Check if the module is allowed to save data
GMod.modMan.incrementUpdateNumber();

S_loadSaver.LSStart(
	sFilePath					:=		getPath(module:=module,dirPath:=FALSE), 
	xReadWrite					:=		TRUE,
	dontLog						:=		dontLog OR module^.SYS_dontLog
);
//Unique ID is gotten from file
S_loadSaver.addKey(name:=GTSmall.Suid);
S_loadSaver.writeDint(value:=module^._UID);
IF module^._name <> 0 AND module^.SYS_nameWrite THEN
	S_loadSaver.addKey(name:=GTSmall.Sname);
	structWriteModuleName(module:=module,writer:=S_loadSaver,mode:=1);
END_IF
IF module^._unit <> 0 AND module^.SYS_unitWrite THEN
	S_loadSaver.addKey(name:=GTSmall.Sunit);
	writeModuleUnitToStruct(module:=module,writer:=S_loadSaver,mode:=1);
END_IF
S_loadSaver.addKey(name:=GTSmall.SsubID);
S_loadSaver.writeDint(value:=module^._SID);
//The modules own parameters are added
S_loadSaver.addKey(name:=GTSmall.Sparams);
S_loadSaver.objectStart(singleLine:=FALSE);
module^.SYS_saveData(saver:=S_loadSaver);
S_loadSaver.structEnd();
S_loadSaver.LSEnd();
//Action for external saving is called, to allow an module to save it's own files
SYS_saveDataExt(loadSaver:=S_loadSaver);