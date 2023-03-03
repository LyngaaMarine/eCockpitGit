//Pushes the given element to the queue
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD pushManuel : BOOL
VAR_INPUT
	valuePoint	:POINTER TO BYTE;
	valueSize	:DWORD;
END_VAR
VAR
	i			:DWORD;
	buffer		:POINTER TO BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
WHILE S_amount < S_bufferSize DO
	IF __COMPARE_AND_SWAP(ADR(S_blockInput),0,1) THEN
		IF S_amount = S_bufferSize THEN
			S_blockInput			:=		0;
			RETURN;
		END_IF
		IF S_input < S_bufferSize - 1 THEN
			S_input					:=		S_input + 1;
		ELSE
			S_input					:=		0;
		END_IF
		buffer						:=		S_buffer + (S_elementSize * S_input);
		FOR i := 1 TO S_elementSize DO
			IF i > valueSize THEN
				buffer^				:=		0;
			ELSE
				buffer^				:=		valuePoint^;
			END_IF
			buffer					:=		buffer + 1;
			valuePoint				:=		valuePoint + 1;
		END_FOR
		WHILE TRUE DO
			IF __COMPARE_AND_SWAP(ADR(S_block),0,1) THEN
				S_amount			:=		S_amount + 1;
				S_block				:=		0;
				EXIT;
			END_IF	
		END_WHILE

		pushManuel					:=		TRUE;
		S_blockInput				:=		0;
		RETURN;
	END_IF	
END_WHILE