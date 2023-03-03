METHOD queryManagementEvent : SLMResult
VAR_INPUT
	event			:EManagementEvent;
	client			:AModuleUID;
	module			:AModuleUID;
	des				:AModuleDes;
	mid				:AMessageID;
	data			:POINTER TO EASCII;
	dataLen			:DWORD;
END_VAR
VAR
	i				:DWORD;
	index			:DWORD;
	trans			:DWORD;
	moverPoint		:POINTER TO EASCII;
END_VAR
(*%!%__DELIMITER__%!%*)
IF dataLen = 0 THEN
	IF S_noDataFIFO.pushStart(index=>index) THEN
		S_noDataBuffer[index].event			:=		event;
		S_noDataBuffer[index].client		:=		client;
		S_noDataBuffer[index].module		:=		module;
		S_noDataBuffer[index].des			:=		des;
		S_noDataBuffer[index].mid			:=		mid;
		S_noDataFIFO.pushEnd();
	ELSE
		queryManagementEvent.success		:=		FALSE;
		queryManagementEvent.code			:=		ERCodes.ModuleManager_queryManagementEvent;
		queryManagementEvent.reason			:=		GTErrors.EqueueFull;
	END_IF
ELSE
	IF S_dataFIFO.pushStart(index=>index) THEN
		S_dataBuffer[index].event			:=		event;
		S_dataBuffer[index].client			:=		client;
		S_dataBuffer[index].module			:=		module;
		S_dataBuffer[index].des				:=		des;
		S_dataBuffer[index].mid				:=		mid;
		trans								:=		MIN(dataLen,GConstants.moduleCommunicationBufferSize);
		moverPoint							:=		ADR(S_dataBuffer[index].data);
		S_dataBuffer[index].dataSize		:=		trans;
		FOR i := 1 TO trans DO
			moverPoint^						:=		data^;
			data							:=		data + 1;
			moverPoint						:=		moverPoint + 1;	
		END_FOR
		
		S_dataFIFO.pushEnd();
	ELSE
		queryManagementEvent.success		:=		FALSE;
		queryManagementEvent.code			:=		ERCodes.ModuleManager_queryManagementEvent;
		queryManagementEvent.reason			:=		GTErrors.EqueueFull;
	END_IF
END_IF