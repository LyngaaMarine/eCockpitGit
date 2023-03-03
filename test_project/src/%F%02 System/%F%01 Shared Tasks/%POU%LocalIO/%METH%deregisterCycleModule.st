METHOD deregisterCycleModule
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR
(*%!%__DELIMITER__%!%*)
cycleModulesHandler.removeElement(element:=ADR(module),elementSize:=SIZEOF(module),amount:=0);