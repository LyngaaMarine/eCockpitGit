{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Changes the size of the queue in a tread safe way
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD setSize
VAR_INPUT
	size		:DWORD;
END_VAR

!__IMPLEMENTATION__!
WHILE TRUE DO
	IF __COMPARE_AND_SWAP(ADR(S_blockInput),0,1) THEN
		WHILE TRUE DO
			IF __COMPARE_AND_SWAP(ADR(S_blockOutput),0,1) THEN
				S_bufferSize			:=		size;
				S_amount				:=		0;
				S_input					:=		0;
				S_output				:=		0;
				S_blockOutput			:=		0;
				S_blockInput			:=		0;
				RETURN;
			END_IF	
		END_WHILE
	END_IF	
END_WHILE