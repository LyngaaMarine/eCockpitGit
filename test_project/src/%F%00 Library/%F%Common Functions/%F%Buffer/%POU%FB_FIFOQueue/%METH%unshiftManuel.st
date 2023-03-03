//Gets the oldest element from the buffer if there are any
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD unshiftManuel : BOOL
VAR_INPUT
	valuePoint	:POINTER TO BYTE;
	valueSize	:DWORD;
END_VAR
VAR
	i			:DWORD;
	buffer		:POINTER TO BYTE;
	trans		:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
WHILE S_amount > 0 DO
	IF __COMPARE_AND_SWAP(ADR(S_blockOutput),0,1) THEN
		IF S_amount = 0 THEN
			S_blockOutput			:=		0;
			RETURN;
		END_IF
		IF S_output < S_bufferSize - 1 THEN
			S_output				:=		S_output + 1;
		ELSE
			S_output				:=		0;
		END_IF
		buffer						:=		S_buffer + (S_elementSize * S_output);
		trans						:=		MIN(valueSize,S_elementSize);
		FOR i := 1 TO trans DO
			IF i > valueSize THEN
				valuePoint^			:=		0;
			ELSE
				valuePoint^			:=		buffer^;
			END_IF
			buffer					:=		buffer + 1;
			valuePoint				:=		valuePoint + 1;
		END_FOR
		WHILE TRUE DO
			IF __COMPARE_AND_SWAP(ADR(S_block),0,1) THEN
				S_amount			:=		S_amount - 1;
				S_block				:=		0;
				EXIT;
			END_IF
		END_WHILE			

		unshiftManuel				:=		TRUE;
		S_blockOutput				:=		0;
		RETURN;
	END_IF
END_WHILE