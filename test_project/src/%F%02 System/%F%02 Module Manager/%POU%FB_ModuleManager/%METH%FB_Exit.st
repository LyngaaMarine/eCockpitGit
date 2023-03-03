{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//FB_Exit must be implemented explicitly. If there is an implementation, then the
//method is called before the controller removes the code of the function block instance
//(implicit call). The return value is not evaluated.
METHOD FB_Exit: BOOL
VAR_INPUT
    bInCopyCode			:BOOL;  // TRUE: the exit method is called in order to leave the instance which will be copied afterwards (online change).  
END_VAR
VAR
	i					:WORD;
	moduleBuffer		:POINTER TO FB_Module;	//Buffer for the module
END_VAR
!__IMPLEMENTATION__!
//All modules in the system are notified of deletion
FOR i := 1 TO S_modulesAmount DO
	S_modulesInOrder[i]^.SYS_unload();
END_FOR