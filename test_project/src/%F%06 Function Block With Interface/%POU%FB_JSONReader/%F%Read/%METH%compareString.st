{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//Returns true if the inputted string is the same as the read string
METHOD compareString : BOOL
VAR_INPUT
	str				:POINTER TO EASCII;
END_VAR
VAR
	posBuffer		:POINTER TO EASCII := lastValueStart + 1;		//Buffer for key position
END_VAR
!__IMPLEMENTATION__!
IF ready AND_THEN lastValueType = EStructType.tString THEN
	WHILE posBuffer <= bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:
				compareString			:=		str^ = EASCII.Null;
				EXIT;
			EASCII.DoubleQoute:
				IF checkNoBackSlash(checkPos:=posBuffer) THEN
					compareString		:=		str^ = EASCII.Null;
					EXIT;
				END_IF
		END_CASE
		IF str^ <> posBuffer^ THEN
			IF posBuffer^ = EASCII.BackSlash THEN
				posBuffer				:=		posBuffer + 1;
				IF str^ <> posBuffer^ THEN
					EXIT;
				END_IF
			ELSE
				EXIT;
			END_IF
		END_IF
		str								:=		str + 1;
		posBuffer						:=		posBuffer + 1;
	END_WHILE
END_IF