{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This adds a string of text to the xml buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD PROTECTED AddChar
VAR_INPUT
	bChar			:BYTE;	//Address of string for the comment text
END_VAR
VAR
	MethodID		:BYTE := 10;			//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND EOBReached = FALSE THEN		//It only runs when a buffer has been initialized
	IF bChar <> 0 THEN						//Checks if character is not null
		IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
			FileBufferADR^		:=		bChar;	
			FileBufferADR		:=		FileBufferADR + 1;
		ELSE									//When the last address is encountered, the end of buffer variable is set true
			FileBufferADR^		:=		bChar;	
			EOBReached			:=		TRUE;
			BufferBroken		:=		TRUE;
		END_IF
	END_IF

	//Last Method is recorded
	LastMethod						:=		MethodID;
END_IF
