{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This adds a character to the JSON buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD PROTECTED addChar
VAR_INPUT
	char			:EASCII;
END_VAR
!__IMPLEMENTATION__!
IF ready THEN		//It only runs when a buffer has been initialized
	IF bufferPosition < bufferMaxADR THEN	//In normal conditions
		bufferPosition^		:=		char;	
		bufferPosition		:=		bufferPosition + 1;
	ELSE									//When the last address is encountered, the end of buffer variable is set true
		bufferInvalid		:=		TRUE;	
	END_IF
END_IF
