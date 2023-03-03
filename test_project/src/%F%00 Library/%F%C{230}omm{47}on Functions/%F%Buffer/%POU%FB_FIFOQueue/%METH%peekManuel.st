{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Gets the oldest element from the buffer if there are any, without removing it from the buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD peekManuel : BOOL
VAR_INPUT
	valuePoint	:POINTER TO BYTE;
	valueSize	:DWORD;
END_VAR
VAR
	i			:DWORD;
	position	:DWORD;
	buffer		:POINTER TO BYTE;
	trans		:DWORD;
END_VAR
!__IMPLEMENTATION__!
WHILE S_amount > 0 DO
	IF __COMPARE_AND_SWAP(ADR(S_blockOutput),0,1) THEN
		IF S_amount = 0 THEN
			S_blockOutput			:=		0;
			RETURN;
		END_IF
		IF S_output < S_bufferSize THEN
			position				:=		S_output + 1;
		ELSE
			position				:=		0;
		END_IF
		buffer						:=		S_buffer + (S_elementSize * position);
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
		peekManuel					:=		TRUE;
		S_blockOutput				:=		0;
		RETURN;
	END_IF
END_WHILE