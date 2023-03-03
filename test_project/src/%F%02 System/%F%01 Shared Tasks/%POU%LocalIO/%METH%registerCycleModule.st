METHOD registerCycleModule : SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR

(*%!%__DELIMITER__%!%*)
registerCycleModule		:=		cycleModulesHandler.appendElement(element:=ADR(module),elementSize:=SIZEOF(module));