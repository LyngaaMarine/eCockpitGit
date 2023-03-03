//This method moves the modules files and file struct from one place to another
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-02-22 | Creation
METHOD PROTECTED moveModule : SLMResult
VAR_INPUT
	moduleToMove		:POINTER TO FB_Module;		//The module to move
	newParentModule		:POINTER TO FB_Module;		//The module to move the module into
	newSID				:AModuleSID;				//The new sub id to give the module
END_VAR
VAR
	i				:WORD;
	subID			:AModuleSID;
END_VAR
(*%!%__DELIMITER__%!%*)
IF moduleToMove = 0 OR newParentModule = 0 THEN
	moveModule.success				:=		FALSE;
	moveModule.code					:=		ERCodes.ModuleManager_moveModuleFile;
	RETURN;
END_IF

IF newParentModule = moduleToMove^._parent THEN	
	subID											:=		moduleToMove^._SID;
	//If new subid is same as old subid nothing is done
	IF newSID = subID THEN
		RETURN;
	//When new sub id is smaller than old one
	ELSIF newSID < subID THEN
		FOR i := subID TO newSID + 1 BY -1 DO
			newParentModule^._children^[i - 1]		:=		newParentModule^._children^[i - 2];
			moveModuleFile(moduleToMove:=newParentModule^._children^[i - 1],newParentModule:=newParentModule,newSID:=i);
		END_FOR
	//When new sub id is bigger than old one
	ELSIF newSID > subID THEN
		FOR i := subID TO newSID - 1 DO
			newParentModule^._children^[i - 1]		:=		newParentModule^._children^[i];
			moveModuleFile(moduleToMove:=newParentModule^._children^[i - 1],newParentModule:=newParentModule,newSID:=i);
		END_FOR
	END_IF
	moveModuleFile(moduleToMove:=moduleToMove,newParentModule:=newParentModule,newSID:=newSID);
ELSE
	;
END_IF