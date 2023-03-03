METHOD queryModuleSave : SLMResult
VAR_INPUT
	moduleUID		:AModuleUID;
	dontLog			:BOOL;
END_VAR
VAR
	index			:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_saveModuleFIFO.pushStart(index=>index) THEN
	S_saveModuleBuffer[index].moduleUID	:=		moduleUID;
	S_saveModuleBuffer[index].dontLog	:=		dontLog;
	S_saveModuleFIFO.pushEnd();
ELSE
	queryModuleSave.success				:=		FALSE;
	queryModuleSave.code				:=		ERCodes.ModuleManager_queryManagementEvent;
	queryModuleSave.reason				:=		GTErrors.EqueueFull;
END_IF