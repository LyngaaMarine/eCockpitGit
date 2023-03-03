{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD registerCycleModule : SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR

!__IMPLEMENTATION__!
registerCycleModule		:=		cycleModulesHandler.appendElement(element:=ADR(module),elementSize:=SIZEOF(module));