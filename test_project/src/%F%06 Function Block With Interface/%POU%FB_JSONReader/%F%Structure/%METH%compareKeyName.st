{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//Returns true if the inputted string is the same as the read string
METHOD compareKeyName : EStructType
VAR_INPUT
	name				:POINTER TO EASCII;
END_VAR
VAR
	posBuffer			:POINTER TO EASCII := lastKeyStart + 1;		//Buffer for key position
END_VAR
!__IMPLEMENTATION__!
IF ready AND_THEN selectedType = EStructType.object THEN
	WHILE posBuffer <= bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:
				IF name^ = EASCII.Null THEN
					compareKeyName		:=		lastValueType;
				END_IF
				EXIT;
			EASCII.DoubleQoute:
				IF checkNoBackSlash(checkPos:=posBuffer) THEN
					IF name^ = EASCII.Null THEN
						compareKeyName		:=		lastValueType;
					END_IF
					EXIT;
				END_IF
		END_CASE
		IF name^ <> posBuffer^ THEN
			IF posBuffer^ = EASCII.BackSlash THEN
				posBuffer				:=		posBuffer + 1;
				IF name^ <> posBuffer^ THEN
					EXIT;
				END_IF
			ELSE
				EXIT;
			END_IF
		END_IF
		name								:=		name + 1;
		posBuffer						:=		posBuffer + 1;
	END_WHILE
END_IF