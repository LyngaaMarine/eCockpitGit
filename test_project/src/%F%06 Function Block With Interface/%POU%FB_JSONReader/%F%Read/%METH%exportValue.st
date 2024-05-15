{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method outputs the start address and size of the current value
//True when ok
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD exportValue : BOOL
VAR_OUTPUT
	position		:POINTER TO EASCII;
	size			:DWORD;
END_VAR
VAR
	inString		:BOOL;
	posBuffer		:POINTER TO EASCII := lastValueStart;
	level			:WORD := 1;		//This value makes sure it doesn't return a key from inside another object
END_VAR
!__IMPLEMENTATION__!
IF ready AND lastValueStart <> 0 THEN
	position					:=		lastValueStart;
	WHILE posBuffer < bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:
				EXIT;
			EASCII.DoubleQoute:
				IF checkNoBackSlash(checkPos:=posBuffer) THEN
					inString	:=		NOT(inString);
				END_IF
			EASCII.CloseBraces,EASCII.SqBracketC:
				IF NOT(inString) THEN
					IF level > 1 THEN
						level	:=		level - 1;
					ELSE
						EXIT;
					END_IF
				END_IF
			EASCII.Comma:
				IF NOT(inString) THEN
					IF level <= 1 THEN
						EXIT;
					END_IF
				END_IF
			EASCII.OpenBraces,EASCII.SqBracketO:
				IF NOT(inString) THEN
					level		:=		level + 1;
				END_IF
		END_CASE	
		posBuffer				:=		posBuffer + 1;
	END_WHILE
	size						:=		posBuffer - position;
	exportValue					:=		TRUE;
END_IF