{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method exits the current object or array
//Returns none, when there are no more keys
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD exitObjectArray : BOOL
VAR
	inString		:BOOL;
	posBuffer		:POINTER TO EASCII := treeSelected[treeLevel] - 1;
	level			:WORD := 1;		//This value makes sure it doesn't return a key from inside another object
	keyFound		:BOOL;
END_VAR
!__IMPLEMENTATION__!
IF ready AND treeLevel > 1 THEN
	WHILE posBuffer >= bufferADROrg DO
		CASE posBuffer^ OF
			EASCII.DoubleQoute:
				IF checkNoBackSlash(checkPos:=posBuffer) THEN
					inString					:=		NOT(inString);
					IF keyFound AND NOT(inString) THEN
						lastKeyStart			:=		posBuffer;
					END_IF
				END_IF
			EASCII.Colon:
				IF NOT(inString) THEN
					keyFound					:=		TRUE;
				END_IF
			EASCII.CloseBraces,EASCII.SqBracketC: 
				IF NOT(inString) THEN
					level						:=		level + 1;
				END_IF
			EASCII.OpenBraces,EASCII.SqBracketO,EASCII.Comma:
				IF NOT(inString) THEN
					IF level = 1 THEN
						lastValueStart			:=		treeSelected[treeLevel];
						lastValueType			:=		treeSelectedTypes[treeLevel];
						treeLevel				:=		treeLevel - 1;
						exitObjectArray			:=		TRUE;
						RETURN;
					ELSE
						level					:=		level - 1;
					END_IF
				END_IF
		END_CASE	
		posBuffer								:=		posBuffer - 1;
	END_WHILE
END_IF