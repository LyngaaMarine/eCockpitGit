{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method finds the next key/value pair in the current object
//Returns none, when there are no more keys
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD nextKey : EStructType
VAR
	inString		:BOOL;
	posBuffer		:POINTER TO EASCII := lastKeyStart;
	level			:WORD;		//This value makes sure it doesn't return a key from inside another object
	foundKeybuffer	:POINTER TO EASCII;
END_VAR
!__IMPLEMENTATION__!
IF ready AND treeLevel > 0 AND treeSelectedTypes[treeLevel] = EStructType.object THEN
	IF posBuffer = 0 THEN
		posBuffer												:=		treeSelected[treeLevel];
	ELSE
		level													:=		1;
	END_IF
	WHILE posBuffer < bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:EXIT;
			EASCII.DoubleQoute: IF checkNoBackSlash(checkPos:=posBuffer) THEN inString := NOT(inString); END_IF
			EASCII.CloseBraces,EASCII.SqBracketC: IF NOT(inString) THEN IF level > 1 THEN level := level - 1;ELSE EXIT; END_IF END_IF
			EASCII.SqBracketO: IF NOT(inString) THEN level := level + 1;END_IF
			EASCII.Comma,EASCII.OpenBraces:
				IF NOT(inString) THEN
					IF posBuffer^ = EASCII.OpenBraces THEN
						level												:=		level + 1;
					END_IF
					IF level = 1 THEN
						WHILE posBuffer <= bufferADRMax DO
							CASE posBuffer^ OF
								EASCII.Null:EXIT;
								EASCII.DoubleQoute:
									IF checkNoBackSlash(checkPos:=posBuffer) THEN
										inString := NOT(inString);
									END_IF
									IF foundKeybuffer = 0 THEN
										foundKeybuffer			:=		posBuffer;
									END_IF
								EASCII.Colon:
									IF NOT(inString) THEN
										nextKey					:=		getType(valueFirstByte:=posBuffer + 1,valuePos=>lastValueStart);
										lastValueType			:=		nextKey;
										lastKeyStart			:=		foundKeybuffer;
										lastKeySize				:=		TO_WORD(posBuffer - foundKeybuffer - 1);
										RETURN;
									END_IF	
							END_CASE
							posBuffer							:=		posBuffer + 1;
						END_WHILE
					END_IF
				END_IF
		END_CASE	
		posBuffer												:=		posBuffer + 1;
	END_WHILE
	nextKey														:=		EStructType.none;
END_IF