{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Gets the next free index in the array, and locks inputs from other threads
//pushEnd must be called to free the thread lock made in this method
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD pushStart : BOOL
VAR_OUTPUT
	index		:DWORD;
END_VAR
!__IMPLEMENTATION__!
WHILE S_amount < S_bufferSize DO
	IF __COMPARE_AND_SWAP(ADR(S_blockInput),0,1) THEN
		IF S_amount = S_bufferSize THEN
			S_blockInput			:=		0;
			RETURN;
		END_IF
		IF S_input < S_bufferSize - 1 THEN
			index					:=		S_input + S_startIndex + 1;
		ELSE
			index					:=		S_startIndex;
		END_IF
		pushStart					:=		TRUE;
		RETURN;
	END_IF	
END_WHILE