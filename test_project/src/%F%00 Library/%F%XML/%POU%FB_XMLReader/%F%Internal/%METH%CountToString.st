//This method counts how long til the requested string is next present from the cursor
//Returns the amount of bytes between cursor and char
//It skips the byte the cursor is at
//Returns 0 if not found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD PROTECTED CountToString :DWORD
VAR_INPUT
	pText			:POINTER TO BYTE;		//Address of the text to count to
	dwAmount		:DWORD;					//Amount of the text to count to
	xInTag			:BOOL;					//If it should only search in the same tag
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;		//Buffer for cursor position
	TextBuffer		:POINTER TO BYTE;		//Buffer for text adress
	AmountBuffer	:DWORD;					//Buffer for text amount
	CountBuffer		:Dword;					//Buffer for count value
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND pText <> 0 AND dwAmount <> 0 THEN			//It only runs when a buffer has been initialized
	CursorBuffer						:=		ADRCursor + 1;
	CountToString						:=		CountToString + 1;
	WHILE CursorBuffer < FileBufferMaxADR - 1 DO			//The entire buffer is run through if nothing stops it
		IF xInTag THEN
			IF CursorBuffer^ = EASCII.GreatThan THEN
				CountTostring			:=		0;
				RETURN;
			END_IF
		END_IF
		
		IF CursorBuffer^ = pText^ THEN						//The first correct character is found
			IF dwAmount = 1 THEN
				RETURN;
			END_IF
			CountBuffer					:=		CountToString;
			TextBuffer					:=		pText + 1;
			AmountBuffer				:=		dwAmount - 1;
			CursorBuffer				:=		CursorBuffer + 1;
			CountToString				:=		CountToString + 1;
			WHILE AmountBuffer > 0 DO
				IF TextBuffer^ = CursorBuffer^ AND CursorBuffer < FileBufferMaxADR - 1 THEN			//If the name bytes are equal to the cursor bytes
					TextBuffer			:=		TextBuffer + 1;		//Name is scanned in reverse
					CursorBuffer		:=		CursorBuffer + 1;
					AmountBuffer		:=		AmountBuffer - 1;
					CountToString		:=		CountToString + 1;
					IF AmountBuffer = 0 THEN
						CountToString	:=		CountBuffer;
						RETURN;
					END_IF
				ELSE
					EXIT;
				END_IF
			END_WHILE
		END_IF
		CursorBuffer					:=		CursorBuffer + 1;
		CountToString					:=		CountToString + 1;
	END_WHILE
	CountTostring						:=		0;
END_IF
