{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": true, "enable_system_call": false}
//Method called during initialization process, for all modules loaded
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-11-20 | Creation
METHOD SYS_init : SLMResult
VAR_IN_OUT
	pouSpeed		:WORD;
END_VAR
VAR
	i			:WORD;
END_VAR
!__IMPLEMENTATION__!
S_systemModbusMultiPlexer.messageHandler	:=		THIS^;
S_systemModbusMultiPlexer.initialize(
	controllers				:=		ADR(S_systemModbusControllers),
	controllersSize			:=		S_maxSystemModbusControllers,
	listeners				:=		ADR(S_systemModbusListeners),
	listenersSize			:=		S_maxSystemModbusListeners,
);
FOR i := 0 TO S_maxSystemModbusControllers DO
	S_systemModbusControllers[i].initialize(
		recieveBuffer		:=		ADR(S_systemModbusRecieveBuffer[i]),
		recieveBufferSize	:=		S_systemModbusRecieveBufferSize,
		sendBuffer			:=		ADR(S_systemModbusSendBuffer[i]),
		sendBufferSize		:=		S_systemModbusSendBufferSize,
		sendMaxSize			:=		SIZEOF(UMBNetMessages),
		maxMessages			:=		50,
		headerSize			:=		6
	);
END_FOR