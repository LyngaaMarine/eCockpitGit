{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": true, "enable_system_call": false}
METHOD queryModuleUpdate : SLMResult
VAR_INPUT
	moduleUID		:AModuleUID;
	client			:AModuleUID;
	mid				:AMessageID;
END_VAR
VAR
	index			:DWORD;
END_VAR
!__IMPLEMENTATION__!
IF S_updateModuleFIFO.pushStart(index=>index) THEN
	S_updateModuleBuffer[index].moduleUID		:=		moduleUID;
	S_updateModuleBuffer[index].clientUID		:=		client;
	S_updateModuleBuffer[index].mid			:=		mid;
	S_updateModuleFIFO.pushEnd();
ELSE
	queryModuleUpdate.success				:=		FALSE;
	queryModuleUpdate.code					:=		ERCodes.ModuleManager_queryManagementEvent;
	queryModuleUpdate.reason				:=		GTErrors.EqueueFull;
END_IF