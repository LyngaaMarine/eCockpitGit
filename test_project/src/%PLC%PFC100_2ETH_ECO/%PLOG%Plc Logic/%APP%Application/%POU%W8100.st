{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM W8100
VAR
	boot			:BOOL;
END_VAR

// VAR_OUTPUT
// 	pms				:FB_PMS := (_name:=ADR('PMS System'));
// END_VAR
!__IMPLEMENTATION__!
boot				:=		PRG_BootManager.bootFinished;