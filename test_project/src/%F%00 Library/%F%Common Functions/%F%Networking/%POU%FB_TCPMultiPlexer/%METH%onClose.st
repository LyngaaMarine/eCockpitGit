//Called when controller conection is closed
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD onClose
VAR_INPUT
	index			:WORD;				//Index set to controller
END_VAR
VAR_IN_OUT
	controller		:FB_TCPController;	//Controller which is closed
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_nextClosed >= S_controllersSize THEN
	//Next free client is found for next incoming connection
	FOR S_nextClosed := 0 TO S_controllersSize DO
		IF NOT(S_controllers^[S_nextClosed].S_open) THEN
			EXIT;
		END_IF	
	END_FOR	
END_IF
IF S_management <> 0 THEN
	S_management.onClose(index:=index,controller:=controller);
END_IF
S_amountConnected		:=		S_amountConnected - 1;