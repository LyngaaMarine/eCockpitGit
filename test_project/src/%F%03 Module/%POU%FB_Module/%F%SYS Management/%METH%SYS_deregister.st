{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for modules to deregister from this module
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-04-22 | Creation
METHOD SYS_deregister
VAR_INPUT
	registrant		:POINTER TO FB_Module;	//Module to deregister
	parameters		:POINTER TO BYTE;		//Extra parameters for deregistering
END_VAR
!__IMPLEMENTATION__!
;