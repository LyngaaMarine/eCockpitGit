{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method copies an amount of bytes from the cursor to the adresse
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 31-05-18 | Creation
METHOD PROTECTED CopyReadData
VAR_INPUT
	pCopyTo			:POINTER TO BYTE;	//Address of the move to place
	dwAmount		:DWORD;				//Amount to move
	xEndString		:BOOL;				//If a zero should be added to the end of the move to adresse
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;	//Buffer for cursor position
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND pCopyTo <> 0 THEN		//It only runs when a buffer has been initialized
	CursorBuffer				:=		ADRCursor;
	ADRCursor					:=		ADRCursor + dwAmount - 1;
	pCopyTo						:=		pCopyTo + dwAmount - 1;
	IF xEndString THEN
		ADRCursor				:=		ADRCursor + 1;
		pCopyTo					:=		pCopyTo + 1;
		dwAmount				:=		dwAmount + 1;
	END_IF
	IF ADRCursor < FileBufferMaxADR THEN
		IF xEndString THEN
			pCopyTo^			:=		0;
			dwAmount			:=		dwAmount - 1;
			ADRCursor			:=		ADRCursor - 1;
			pCopyTo				:=		pCopyTo - 1;
		END_IF
		WHILE dwAmount > 0 DO
			pCopyTo^			:=		ADRCursor^;
			dwAmount			:=		dwAmount - 1;
			ADRCursor			:=		ADRCursor - 1;
			pCopyTo				:=		pCopyTo - 1;
		END_WHILE
	END_IF
	ADRCursor					:=		CursorBuffer;
END_IF
