{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for cleaning up system
//Return true if found
//Return save if the removed module should cause this one to save
//Return dontUpdate
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-01-21 | Creation
METHOD SYS_cleanUp
VAR_INPUT
	mode		:ECleanUpMode;
	modPoint	:POINTER TO FB_Module;	//The module to clean up from this
END_VAR
VAR_IN_OUT
	found		:BOOL;		//Set true if the usage was found
	doSave		:BOOL;		//Set true if the module should be saved
	doUpdate	:BOOL;		//Set true if the module should be updated
END_VAR
!__IMPLEMENTATION__!
