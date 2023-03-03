//Called cyclicly to handle incoming connections
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD acceptCycle
VAR
	i			:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_nextClosed < S_controllersSize THEN
	//Incoming connection is accepted
	IF S_listenersSize > 0 THEN
		FOR i := 0 TO S_listenersSize - 1 DO
			S_controllers^[S_nextClosed].acceptConnection(listener:=S_listeners^[i]);
		END_FOR
	END_IF
END_IF