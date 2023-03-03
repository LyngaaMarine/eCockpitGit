{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD modbusCycle
VAR_INPUT
	pouSpeed			:WORD;
END_VAR
!__IMPLEMENTATION__!
S_systemModbusMultiPlexer.acceptCycle();
S_systemModbusMultiPlexer.messageCycle();
S_systemModbusMultiPlexer.sendCycle();