VAR
	i		:WORD;
END_VAR

(*%!%__DELIMITER__%!%*)
S_messageEvent							:=		messageHandler;
IF S_controllersSize > 0 THEN
	FOR i := 0 TO S_controllersSize - 1 DO
		S_controllers^[i].S_message		:=		S_messageEvent;
	END_FOR
END_IF