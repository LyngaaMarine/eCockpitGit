//This method moves the cursor to the next string equal to the input
//Returns true if string is found
//It skips the byte the cursor is at
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD PROTECTED MoveToString :BOOL
VAR_INPUT
	pText			:POINTER TO BYTE;		//Address of the text to count to
	dwAmount		:DWORD;					//Amount of the text to count to
	xInTag			:BOOL;					//If it should only search in the same tag
	xImediate		:BOOL;					//If it should only search the very next characters
END_VAR
VAR_OUTPUT
	HighestLevel	:INT;					//Outputs the highest passed level
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;		//Buffer for cursor position
	CursorBuffer2	:POINTER TO BYTE;		//Buffer for cursor position
	LayerBuffer		:INT;					//Keeps track of layer
	TextBuffer		:POINTER TO BYTE;		//Buffer for text adress
	AmountBuffer	:DWORD;					//Buffer for text amount
	TreeBuffer		:INT;					//buffer for tree layer
	TreeBuffer2		:INT;					//buffer for tree layer
	ImediateBuff	:BOOL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND pText <> 0 AND dwAmount <> 0 THEN			//It only runs when a buffer has been initialized
	CursorBuffer						:=		ADRCursor;
	TreeBuffer							:=		TreeLevel;
	LayerBuffer							:=		TreeLevel;
	HighestLevel						:=		TreeLevel;
	WHILE CountUp() DO			//The entire buffer is run through if nothing stops it
		IF TreeLevel < HighestLevel THEN
			HighestLevel				:=		TreeLevel;
		END_IF	
	
		IF xImediate	THEN
			IF ImediateBuff THEN
				ADRCursor				:=		CursorBuffer;
				TreeLevel				:=		TreeBuffer;
				RETURN;
			ELSE
				ImediateBuff			:=		TRUE;
			END_IF
		END_IF
		
		IF xInTag THEN
			IF ADRCursor^ = EASCII.GreatThan THEN
				TreeLevel				:=		TreeBuffer;
				ADRCursor				:=		CursorBuffer;
				RETURN;
			END_IF
		END_IF
		
		IF ADRCursor^ = pText^ THEN	//The first correct character is found
			
			IF dwAmount = 1 THEN								//For single byte strings
				MoveToString			:=		TRUE;		//String is found
				RETURN;
			END_IF
			
			TextBuffer					:=		pText + 1;
			AmountBuffer				:=		dwAmount - 1;
			TreeBuffer2					:=		TreeLevel;
			CursorBuffer2				:=		ADRCursor;
			
			WHILE CountUp() DO
				IF AmountBuffer > 0 THEN
					IF TextBuffer^ = ADRCursor^ THEN			//If the name bytes are equal to the cursor bytes
						TextBuffer		:=		TextBuffer + 1;		
						AmountBuffer	:=		AmountBuffer - 1;
						IF AmountBuffer = 0 THEN
							MoveToString:=		TRUE;			//String is found
							RETURN;
						END_IF
					ELSE
						ADRCursor		:=		CursorBuffer2;
						TreeLevel		:=		TreeBuffer2;
						EXIT;
					END_IF
				ELSE
					ADRCursor			:=		CursorBuffer2;
					TreeLevel			:=		TreeBuffer2;
					EXIT;
				END_IF
			END_WHILE
		END_IF
	END_WHILE
	ADRCursor							:=		CursorBuffer;
	TreeLevel							:=		TreeBuffer;
END_IF
