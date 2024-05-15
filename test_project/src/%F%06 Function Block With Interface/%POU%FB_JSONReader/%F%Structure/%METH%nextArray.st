{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method finds the next value in an array
//Returns none, when there are no more entries
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD nextArray : EStructType
VAR
	inString		:BOOL;
	posBuffer		:POINTER TO EASCII := lastValueStart;
	level			:WORD;		//This value makes sure it doesn't return a key from inside another object
END_VAR
!__IMPLEMENTATION__!
IF ready AND treeLevel > 0 AND treeSelectedTypes[treeLevel] = EStructType.tArray THEN
	IF lastValueStart = 0 THEN
		posBuffer									:=		treeSelected[treeLevel];
	ELSE
		level										:=		1;
	END_IF
	WHILE posBuffer <= bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:EXIT;
			EASCII.DoubleQoute: IF checkNoBackSlash(checkPos:=posBuffer) THEN inString := NOT(inString); END_IF
			EASCII.CloseBraces,EASCII.SqBracketC: IF NOT(inString) THEN IF level > 1 THEN level := level - 1;ELSE EXIT; END_IF END_IF
			EASCII.OpenBraces: IF NOT(inString) THEN level := level + 1;END_IF
			EASCII.Comma,EASCII.SqBracketO:
				IF NOT(inString) THEN
					IF posBuffer^ = EASCII.SqBracketO THEN
						level						:=		level + 1;
					END_IF
					IF level = 1 THEN
						nextArray					:=		getType(valueFirstByte:=posBuffer + 1,valuePos=>lastValueStart);
						lastValueType				:=		nextArray;
						treeSelectedArrayProg[treeLevel]	:=		treeSelectedArrayProg[treeLevel] + 1;
						RETURN;
					END_IF
				END_IF
		END_CASE	
		posBuffer									:=		posBuffer + 1;
	END_WHILE
	nextArray										:=		EStructType.none;
END_IF