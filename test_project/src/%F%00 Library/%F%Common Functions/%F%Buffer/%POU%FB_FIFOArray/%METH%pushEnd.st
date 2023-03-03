//Releases the lock for getting the next index
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD pushEnd
(*%!%__DELIMITER__%!%*)
WHILE TRUE DO
	IF __COMPARE_AND_SWAP(ADR(S_block),0,1) THEN
		S_amount			:=		S_amount + 1;
		S_block				:=		0;
		EXIT;
	END_IF	
END_WHILE
IF S_input < S_bufferSize - 1 THEN
	S_input					:=		S_input + S_startIndex + 1;
ELSE
	S_input					:=		S_startIndex;
END_IF

S_blockInput				:=		0;