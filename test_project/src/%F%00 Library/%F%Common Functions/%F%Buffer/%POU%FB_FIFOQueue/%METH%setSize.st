//Changes the size of the queue in a tread safe way
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD setSize
VAR_INPUT
	size		:DWORD;
END_VAR

(*%!%__DELIMITER__%!%*)
WHILE TRUE DO
	IF __COMPARE_AND_SWAP(ADR(S_block),0,1) THEN
		S_bufferSize					:=		size;
		S_amount				:=		0;
		S_input					:=		0;
		S_output				:=		0;
		S_block					:=		0;
		RETURN;
	END_IF	
END_WHILE