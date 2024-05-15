{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD readKeyNameLevel : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
	lenMax			:DWORD;
	level			:BYTE;					//The level to get from
END_VAR
VAR_OUTPUT
	len				:WORD;
END_VAR
VAR
	posBuffer		:POINTER TO EASCII;		//Buffer for key position
	inString		:BOOL;
	i				:WORD;
	arrString		:STRING(7);				//Buffer used for outputting array number
END_VAR
!__IMPLEMENTATION__!
IF ready AND level <= treeLevel AND treeLevel > 0 AND level > 0 THEN
	CASE treeSelectedTypes[level] OF
		EStructType.tArray:
			arrString						:=		FU_sConcat3(s1:='[',s2:=TO_STRING(treeSelectedArrayProg[level]),s3:=']');
			WHILE len <= 7 AND lenMax > 0 DO
				name^						:=		arrString[len];
				name						:=		name + 1;
				len							:=		len + 1;
				lenMax						:=		lenMax - 1;
				IF arrString[len] = EASCII.Null THEN
					EXIT;
				END_IF
			END_WHILE
			name^							:=		EASCII.Null;		
		EStructType.object:
			IF level = treeLevel THEN
				readKeyName(name:=name,lenMax:=lenMax,len=>len);
			ELSE
				posBuffer						:=		treeSelected[level + 1] - 1;
				WHILE posBuffer > bufferADROrg DO
					IF inString THEN
						len						:=		len + 1;
					END_IF
					CASE posBuffer^ OF
						EASCII.Null:EXIT;
						EASCII.DoubleQoute:
							IF checkNoBackSlash(checkPos:=posBuffer) THEN
								IF inString THEN
									len			:=		len - 1;
									posBuffer	:=		posBuffer + 1;
									EXIT;
								ELSE
									inString	:=		TRUE;
								END_IF
							END_IF
					END_CASE
					posBuffer					:=		posBuffer - 1;
				END_WHILE
				FOR i := 1 TO len DO
					name^						:=		posBuffer^;
					name						:=		name + 1;
					lenMax						:=		lenMax - 1;
					posBuffer					:=		posBuffer + 1;
					IF lenMax = 0 THEN
						EXIT;
					END_IF
				END_FOR
				name^							:=		EASCII.Null;
				readKeyNameLevel				:=		TRUE;
			END_IF
	END_CASE
END_IF