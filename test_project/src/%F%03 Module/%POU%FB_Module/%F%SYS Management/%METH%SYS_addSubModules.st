{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method called during initialization process, if this module add fixed sub modules, they should be added here
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-11-20 | Creation
METHOD SYS_addSubModules : SLMResult
VAR_INPUT
	boot		:BOOL;		//Is true when creation happens during boot
END_VAR
!__IMPLEMENTATION__!
;