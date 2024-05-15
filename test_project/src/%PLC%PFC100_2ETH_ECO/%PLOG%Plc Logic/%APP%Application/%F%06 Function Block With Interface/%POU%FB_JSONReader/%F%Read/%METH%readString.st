{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD readString
VAR_INPUT
	str				:POINTER TO EASCII;		//Address of the buffer to write the string to
	lenMax			:DWORD;					//Max lenght of the buffer
END_VAR
VAR_OUTPUT
	len				:WORD;
END_VAR
VAR
	posBuffer		:POINTER TO EASCII;		//Buffer for key position
	utfFix			:POINTER TO EASCII;
	inString		:BOOL;
	level			:WORD := 1;		//This value makes sure it doesn't return a key from inside another object
END_VAR
!__IMPLEMENTATION__!
IF ready AND_THEN lastValueType <> EStructType.none THEN
	CASE lastValueType OF
		EStructType.tArray,EStructType.object:
			posBuffer				:=		lastValueStart;
			WHILE posBuffer <= bufferADRMax AND lenMax > 0 DO
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
				str^				:=		posBuffer^;
				str					:=		str + 1;
				posBuffer			:=		posBuffer + 1;
				lenMax				:=		lenMax - 1;
			END_WHILE
			len						:=		TO_WORD(posBuffer - lastValueStart - 1);
			str^					:=		EASCII.Null;
		EStructType.number,EStructType.tBool,EStructType.null:
			posBuffer				:=		lastValueStart;
			WHILE posBuffer <= bufferADRMax AND lenMax > 0 DO
				CASE posBuffer^ OF
					EASCII.CloseBraces,EASCII.SqBracketC,EASCII.Comma,EASCII.Null:EXIT;
				END_CASE
				str^				:=		posBuffer^;
				str					:=		str + 1;
				posBuffer			:=		posBuffer + 1;
				lenMax				:=		lenMax - 1;
			END_WHILE
			len						:=		TO_WORD(posBuffer - lastValueStart - 1);
			str^					:=		EASCII.Null;
		EStructType.tString:
			posBuffer				:=		lastValueStart + 1;
			WHILE posBuffer <= bufferADRMax AND lenMax > 0 DO
				CASE posBuffer^ OF
					EASCII.Null:EXIT;
					EASCII.DoubleQoute:
						IF checkNoBackSlash(checkPos:=posBuffer) THEN
							EXIT;
						ELSE
							str		:=		str - 1;
						END_IF
				END_CASE
				str^				:=		posBuffer^;
				str					:=		str + 1;
				posBuffer			:=		posBuffer + 1;
				lenMax				:=		lenMax - 1;
			END_WHILE
			len						:=		TO_WORD(posBuffer - lastValueStart - 1);
			str^					:=		EASCII.Null;
			CASE FU_CheckUTF8(strStart:=str - len,char:=str - 1, start=>utfFix) OF
				1,2,4:
					utfFix^			:=		0;
					len				:=		len - TO_WORD(str - utfFix);
			END_CASE
	END_CASE
END_IF