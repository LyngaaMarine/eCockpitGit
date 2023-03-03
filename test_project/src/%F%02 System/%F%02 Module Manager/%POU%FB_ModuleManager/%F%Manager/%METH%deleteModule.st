//This method deletes an module from the registry, and frees the dynamic memory, if it has ANY
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-06-19 | Creation
METHOD deleteModule
VAR_INPUT
	moduleBuffer		:POINTER TO FB_Module;		//The ID of the io to get
	dontDeleteDir		:BOOL;						//Set true to skip deletion of directory, only used for recursive deletion
	dontUpdate			:BOOL;						//Set true to skip client update, only used for recursive deletion
	mid					:AMessageID;				//Number to identify request by
	client				:AModuleUID;				//Client who performed request
END_VAR
VAR
	i					:WORD;
	amountBuffer		:WORD;
	doSave				:BOOL;
	doUpdate			:BOOL;
	found				:BOOL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF moduleBuffer = 0 THEN
	RETURN;
END_IF
incrementUpdateNumber();
//Tells module to clean up
moduleBuffer^.SYS_destructor();
//All submodules are deleted
IF moduleBuffer^._amountChildren > 0 THEN
	FOR i := 0 TO moduleBuffer^._amountChildren - 1 DO
		GMod.modMan.deleteModule(moduleBuffer:=moduleBuffer^._children^[i],dontDeleteDir:=TRUE,dontUpdate:=TRUE,mid:=0,client:=0);
	END_FOR
END_IF
//All modules in the system are notified of deletion
FOR i := 1 TO S_modulesAmount DO
	S_modulesInOrder[i]^.SYS_cleanUp(mode:=ECleanUpMode.cleanPointers,modPoint:=moduleBuffer,doSave:=doSave,doUpdate:=doUpdate,found:=found);
	IF doSave THEN
		saveModule(module:=S_modulesInOrder[i],dontLog:=TRUE);
	END_IF
	IF doUpdate THEN
		///updateClients(module:=S_modulesInOrder[i],client:=0,mid:=0);
	END_IF
END_FOR
//Global client update for module deletion
// IF NOT(dontUpdate) THEN
// 	S_commander.writeReset();
// 	S_commander.writeAddTypeCode(char:=EASCII.BigS);
// 	S_commander.writeAddTypeCode(char:=EASCII.BigR);
// 	S_commander.writeJSONInit(jsonType:=EStructType.object);
// 	IF mid <> 0 THEN
// 		S_commander.jSONWriter.addKey(name:=GTSmall.Snum);
// 		S_commander.jSONWriter.writeDint(value:=mid);
// 	END_IF
// 	IF client <> 0 THEN
// 		S_commander.jSONWriter.addKey(name:=GTSmall.Sclient);
// 		S_commander.jSONWriter.writeDint(value:=client);
// 	END_IF
// 	S_commander.jSONWriter.addKey(name:=GTSmall.Supdate);
// 	S_commander.jSONWriter.writeDint(value:=GMod.modMan.S_moduleUpdate);
// 	S_commander.jSONWriter.addKey(name:=GTSmall.SmodID);
// 	S_commander.jSONWriter.writeDint(value:=moduleBuffer^._UID);
// 	GDataServer.dataServer.globalSendCommand(commander:=S_commander,needSynced:=FALSE);	
// END_IF
//Log is added
logModuleChange(module:=moduleBuffer,logType:=0);
//Module is removed from registry
deregisterModuleByUID(module:=moduleBuffer);
removeFromOrderedList(module:=moduleBuffer);
//File is deleted
FU_deleteFileByName(sFilePath:=getPath(module:=moduleBuffer,dirPath:=FALSE));
IF NOT(dontDeleteDir) THEN
	FU_deleteDirByName(sDirPath:=getPath(module:=moduleBuffer,dirPath:=TRUE),xOnlyContent:=FALSE);
END_IF
//Name is deleted
FU_SafeDelete(pMem:=moduleBuffer^._name);
//Unit is cleaned up			
FU_SafeDelete(pMem:=moduleBuffer^._unit);
//Child is removed from parent
registerChildWithModule(parentModule:=moduleBuffer^._parent,childModule:=moduleBuffer,deOrRegister:=TRUE);
//Memory is deallocated
FU_SafeDelete(pMem:=moduleBuffer);