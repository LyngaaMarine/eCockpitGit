{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This adds a string of text to the xml buffer
//Illigal characters, <, > they will be skipped
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD PROTECTED AddString
VAR_INPUT
	pString			:POINTER TO BYTE;	//Address of string for the comment text
	xFilled			:BOOL;				//If filler text should be used
	dwFillerSize	:BYTE;				//Size of filler text, if filler does not fill the size, the empty spaces will be replaced with #
END_VAR
VAR
	WatchDog		:BYTE;		//Watchdog for keeping addresse reading in check
	MethodID		:BYTE := 3;			//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND EOBReached = FALSE THEN		//It only runs when a buffer has been initialized
	IF pString <> 0 THEN						//Checks if stringaddress is not empty
		IF xFilled THEN							//If filled mode is selected
			WHILE dwFillerSize > 0 DO				//Runs until comepletely filled
				IF pString^ = EASCII.Null THEN	//When null is detected, hash is used instead
					IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
						FileBufferADR^	:=		EASCII.Hash;	
						FileBufferADR	:=		FileBufferADR + 1;
						dwFillerSize		:=		dwFillerSize - 1;
					ELSE										//When the last address is encountered, the end OF buffer variable is set TRUE
						FileBufferADR^	:=		EASCII.Hash;	
						EOBReached		:=		TRUE;
						BufferBroken	:=		TRUE;
						EXIT;
					END_IF
				ELSIF pString^ = EASCII.LessThan OR pString^ = EASCII.GreatThan THEN	//Illeagal charaters are skipped
					pString			:=		pString + 1;
				ELSE
					IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
						FileBufferADR^	:=		pString^;	
						pString		:=		pString + 1;
						FileBufferADR	:=		FileBufferADR + 1;
						dwFillerSize		:=		dwFillerSize - 1;
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
				IF pString^ = EASCII.LessThan OR pString^ = EASCII.GreatThan THEN	//Illegal charaters are skipped
					pString			:=		pString + 1;
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
