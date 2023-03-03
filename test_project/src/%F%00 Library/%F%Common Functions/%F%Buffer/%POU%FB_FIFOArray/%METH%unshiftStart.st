//Gets the oldest element from the buffer if there are any
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD unshiftStart : BOOL
VAR_OUTPUT
	index		:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
WHILE S_amount > 0 DO
	IF __COMPARE_AND_SWAP(ADR(S_blockOutput),0,1) THEN
		IF S_amount = 0 THEN
			S_blockOutput			:=		0;
			RETURN;
		END_IF
		IF S_output < S_bufferSize - 1 THEN
			index					:=		S_output + S_startIndex + 1;
		ELSE
			index					:=		S_startIndex;
		END_IF
		unshiftStart				:=		TRUE;
		RETURN;
	END_IF
END_WHILE