METHOD modbusCycle
VAR_INPUT
	pouSpeed			:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
S_systemModbusMultiPlexer.acceptCycle();
S_systemModbusMultiPlexer.messageCycle();
S_systemModbusMultiPlexer.sendCycle();