METHOD registerNetworkModule : SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR

(*%!%__DELIMITER__%!%*)
registerNetworkModule		:=		networkModulesHandler.appendElement(element:=ADR(module),elementSize:=SIZEOF(module));