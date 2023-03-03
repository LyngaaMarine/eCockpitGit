PROGRAM W8100
VAR
	boot			:BOOL;
END_VAR

// VAR_OUTPUT
// 	pms				:FB_PMS := (_name:=ADR('PMS System'));
// END_VAR
(*%!%__DELIMITER__%!%*)
boot				:=		PRG_BootManager.bootFinished;