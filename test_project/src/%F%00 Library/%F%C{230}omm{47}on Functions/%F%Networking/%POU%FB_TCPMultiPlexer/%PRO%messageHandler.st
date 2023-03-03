{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Used to set message handler for controllers
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
PROPERTY messageHandler : ITF_TCPControllerMessage
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
messageHandler			:=		S_messageEvent;
!__SETTER__!
VAR
	i		:WORD;
END_VAR

!__IMPLEMENTATION__!
S_messageEvent							:=		messageHandler;
IF S_controllersSize > 0 THEN
	FOR i := 0 TO S_controllersSize - 1 DO
		S_controllers^[i].S_message		:=		S_messageEvent;
	END_FOR
END_IF