//This adds a string of text to the xml buffer, but has a stricter allowance for charaters
//Illigal characters, <, >,  , ", =, ', &, !,
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
// | 2         | NSN      | 02-05-18 | Space added to list of illigal characters
// | 3         | NSN      | 08-06-18 | Exclamation point added to illigal characters
METHOD PROTECTED AddStringStrict
VAR_INPUT
	pString			:POINTER TO BYTE;	//Address of string for the comment text
	xFilled			:BOOL;				//If filler text should be used
	bFillerSize		:BYTE;				//Size of filler text, if filler does not fill the size, the empty spaces will be replaced with #
END_VAR
VAR
	AmountSkipped	:DWORD;				//Amount of bytes skipped, if any
END_VAR
VAR
	WatchDog		:BYTE;				//Watchdog for keeping addresse reading in check
	MethodID		:BYTE := 13;		//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND EOBReached = FALSE THEN		//It only runs when a buffer has been initialized
	IF pString <> 0 THEN						//Checks if stringaddress is not empty
		IF xFilled THEN							//If filled mode is selected
			WHILE bFillerSize > 0 DO				//Runs until comepletely filled
				IF pString^ = EASCII.Null THEN	//When null is detected, hash is used instead
					IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
						FileBufferADR^	:=		EASCII.Hash;	
						FileBufferADR	:=		FileBufferADR + 1;
						bFillerSize		:=		bFillerSize - 1;
					ELSE										//When the last address is encountered, the end OF buffer variable is set TRUE
						FileBufferADR^	:=		EASCII.Hash;	
						EOBReached		:=		TRUE;
						BufferBroken	:=		TRUE;
						EXIT;
					END_IF
				ELSIF pString^ = EASCII.Space OR pString^ = EASCII.LessThan OR pString^ = EASCII.GreatThan OR pString^ = EASCII.DoubleQoute OR pString^ = EASCII.Equal OR pString^ = EASCII.Apostrophe OR pString^ = EASCII.Ampersand OR  pString^ = EASCII.Exclamation THEN	//Illegal charaters are skipped
					pString			:=		pString + 1;
					AmountSkipped		:=		AmountSkipped + 1;
				ELSE
					IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
						FileBufferADR^	:=		pString^;	
						pString		:=		pString + 1;
						FileBufferADR	:=		FileBufferADR + 1;
						bFillerSize		:=		bFillerSize - 1;
					ELSE								//When the last address is encountered, the end of buffer variable is set true
						FileBufferADR^	:=		pString^;	
						EOBReached		:=		TRUE;
						BufferBroken	:=		TRUE;
						EXIT;
					END_IF
				END_IF
			END_WHILE
		ELSE										//If filled mode is not selected
			WHILE pString^ <> EASCII.Null DO			//Runs until null is detected
				IF WatchDog >= 3000 THEN
					EXIT;
				END_IF
				IF pString^ = EASCII.Space OR pString^ = EASCII.LessThan OR pString^ = EASCII.GreatThan OR pString^ = EASCII.DoubleQoute OR pString^ = EASCII.Equal OR pString^ = EASCII.Apostrophe OR pString^ = EASCII.Ampersand THEN	//Illegal charaters are skipped
					pString			:=		pString + 1;
					AmountSkipped		:=		AmountSkipped + 1;
				ELSE
					IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
						FileBufferADR^	:=		pString^;	
						pString		:=		pString + 1;
						FileBufferADR	:=		FileBufferADR + 1;
						WatchDog		:=		WatchDog + 1;
					ELSE								//When the last address is encountered, the end of buffer variable is set true
						FileBufferADR^	:=		pString^;	
						EOBReached		:=		TRUE;
						BufferBroken	:=		TRUE;
						EXIT;
					END_IF
				END_IF
			END_WHILE
		END_IF
	END_IF

	//Last Method is recorded
	LastMethod						:=		MethodID;
END_IF