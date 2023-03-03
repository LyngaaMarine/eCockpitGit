{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This simplifies the cleanup process of a module
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 27-01-21 | Creation
FUNCTION FU_ModuleCleanUpUID : BOOL
VAR_INPUT
	mode		:ECleanUpMode;			//Cleanup mode
	update		:BOOL;					//If set true, when cleaning up after deletion, the update flag is set high to update clients
END_VAR
VAR_IN_OUT
	modClean	:POINTER TO FB_Module;	//Reference to module to clean up from
	modUID		:AModuleUID;			//Reference to stored module id
	found		:BOOL;					//Reference to found var
	save		:BOOL;					//Reference to save var
	doUpdate	:BOOL;					//Reference to update var
END_VAR
!__IMPLEMENTATION__!
IF modUID = modClean^._UID THEN
	found				:=		TRUE;
	IF mode = ECleanUpMode.cleanPointers THEN
		modUID			:=		0;
		save			:=		TRUE;
	END_IF
END_IF