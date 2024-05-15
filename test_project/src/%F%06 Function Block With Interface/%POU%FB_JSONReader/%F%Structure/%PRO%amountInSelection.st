{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
PROPERTY amountInSelection : word
!__GETTER__!
VAR
	inString		:BOOL;
	posBuffer		:POINTER TO EASCII := lastValueStart;
	level			:WORD;		//This value makes sure it doesn't return a key from inside another object
	first			:BOOL;		//Set true when first comma is found
END_VAR
!__IMPLEMENTATION__!
IF ready THEN
	IF treeLevel > 0 THEN
		CASE treeSelectedTypes[treeLevel] OF
			EStructType.object,EStructType.tArray:
				posBuffer									:=		treeSelected[treeLevel];
				WHILE posBuffer <= bufferADRMax DO
					CASE posBuffer^ OF
						EASCII.Null:EXIT;
						EASCII.DoubleQoute:
							IF checkNoBackSlash(checkPos:=posBuffer) THEN
								inString					:=		NOT(inString);
							END_IF
						EASCII.CloseBraces,EASCII.SqBracketC:
							IF NOT(inString) THEN
								IF level > 1 THEN
									level					:=		level - 1;
								ELSE
									EXIT;
								END_IF
							END_IF
						EASCII.OpenBraces,EASCII.SqBracketO:
							IF NOT(inString) THEN 
								level						:= 		level + 1;
							END_IF
						EASCII.Comma:
							IF NOT(inString) THEN
								IF level = 1 THEN
									amountInSelection		:=		amountInSelection + 1;

								END_IF
							END_IF
						EASCII.Space,EASCII.LF,EASCII.CR,EASCII.Tab:;
					ELSE
						IF NOT(first) THEN
							first				:=		TRUE;
							amountInSelection	:=		amountInSelection + 1;
						END_IF
					END_CASE	
					posBuffer								:=		posBuffer + 1;
				END_WHILE
		ELSE
			amountInSelection								:=		1;
		END_CASE
	ELSE
		amountInSelection									:=		1;
	END_IF
ELSE
	amountInSelection										:=		0;	
END_IF
!__SETTER__!
