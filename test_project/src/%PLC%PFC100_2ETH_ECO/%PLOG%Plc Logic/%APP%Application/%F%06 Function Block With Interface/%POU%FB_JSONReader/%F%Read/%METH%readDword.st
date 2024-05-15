{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD readDword : DWORD
VAR
	buffer		:STRING(30);
	posBuffer	:POINTER TO EASCII := lastValueStart;		//Buffer for key position
	i			:BYTE;
END_VAR
!__IMPLEMENTATION__!
IF ready THEN
	CASE lastValueType OF
		EStructType.tBool:
			IF lastValueStart^ = EASCII.Smallt THEN
				readDword			:=		1;
			END_IF
		EStructType.number:
			WHILE posBuffer <= bufferADRMax AND i < 31 DO
				CASE posBuffer^ OF
					EASCII.Zero,EASCII.One,EASCII.Two,EASCII.Three,EASCII.Four,EASCII.Five,EASCII.Six,EASCII.Seven,EASCII.Eight,EASCII.Nine:;
				ELSE
					EXIT;
				END_CASE
				buffer[i]			:=		posBuffer^;
				posBuffer			:=		posBuffer + 1;
				i					:=		i + 1;
			END_WHILE
			buffer[i]				:=		EASCII.Null;
			readDword				:=		TO_DWORD(buffer);
		EStructType.null,EStructType.object,EStructType.tArray:;
		EStructType.tString:
			readString(str:=ADR(buffer),lenMax:=30);
			readDword				:=		TO_DWORD(buffer);
	END_CASE	
END_IF