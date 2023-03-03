{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for modules to register to this module
//If succes is false, registering failed
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-11-20 | Creation
METHOD SYS_register : SLMResult
VAR_INPUT
	registrant		:POINTER TO FB_Module;	//Module to deregister
	parameters		:POINTER TO BYTE;		//Extra parameters for deregistering
END_VAR
!__IMPLEMENTATION__!
;