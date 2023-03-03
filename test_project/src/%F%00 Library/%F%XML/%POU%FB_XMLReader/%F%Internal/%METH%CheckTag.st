{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for checking if tag or struct, looks for tag end </ 
//Returns True if Tag end is found
//Always returns cursor to previous position
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD PROTECTED CheckTag: BOOL
VAR
	pCursorBuffer	:POINTER TO BYTE;	//Buffer for cursor position	
END_VAR
!__IMPLEMENTATION__!
IF Initialized THEN										//Requires initialised
	pCursorBuffer			:=		ADRCursor;			//Cursor location is copied
	WHILE pCursorBuffer < FileBufferMaxADR - 1 DO		//Runs until something is found
		IF pCursorBuffer^ = EASCII.LessThan THEN			//When less than is found
			pCursorBuffer	:=		pCursorBuffer + 1;	//Next address is checked
			IF pCursorBuffer^ = EASCII.Solidus THEN		//If next address is solidus, it is indeed a tag, if not then it must be a struct
				CheckTag	:=		TRUE;
				RETURN;
			ELSE
				RETURN;
			END_IF
		END_IF
		pCursorBuffer		:=		pCursorBuffer + 1;	//Moves cursor one down
	END_WHILE
END_IF