{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method returns the lenght of the the currently selected string
//Returns true on output if length is valid
METHOD readStringLen : WORD
VAR
	posBuffer		:POINTER TO EASCII;		//Buffer for key position
	inString		:BOOL;
	level			:WORD := 1;		//This value makes sure it doesn't return a key from inside another object
END_VAR
!__IMPLEMENTATION__!
IF ready AND_THEN lastValueType <> EStructType.none THEN
	CASE lastValueType OF
		EStructType.tArray,EStructType.object:
			posBuffer					:=		lastValueStart;
			WHILE posBuffer <= bufferADRMax DO
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
			readStringLen				:=		TO_WORD(posBuffer - lastValueStart - 1);
		EStructType.number,EStructType.tBool,EStructType.null:
			posBuffer					:=		lastValueStart;
			WHILE posBuffer <= bufferADRMax DO
				CASE posBuffer^ OF
					EASCII.CloseBraces,EASCII.SqBracketC,EASCII.Comma,EASCII.Null:EXIT;
				END_CASE
				posBuffer				:=		posBuffer + 1;
			END_WHILE
			readStringLen				:=		TO_WORD(posBuffer - lastValueStart - 1);
		EStructType.tString:
			WHILE posBuffer <= bufferADRMax DO
				CASE posBuffer^ OF
					EASCII.Null:EXIT;
					EASCII.DoubleQoute:
						IF checkNoBackSlash(checkPos:=posBuffer) THEN
							EXIT;
						END_IF
				END_CASE
				posBuffer				:=		posBuffer + 1;
			END_WHILE
			readStringLen				:=		TO_WORD(posBuffer - lastValueStart - 1);
	END_CASE
END_IF