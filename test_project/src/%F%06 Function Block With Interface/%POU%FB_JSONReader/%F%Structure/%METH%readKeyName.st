{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD readKeyName : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
	lenMax			:DWORD;
END_VAR
VAR_OUTPUT
	len				:WORD;
END_VAR
VAR
	posBuffer		:POINTER TO EASCII := lastKeyStart + 1;		//Buffer for key position
END_VAR
!__IMPLEMENTATION__!
IF ready AND lastValueType <> EStructType.none AND treeLevel > 0 THEN
	WHILE posBuffer <= bufferADRMax AND lenMax > 0 DO
		CASE posBuffer^ OF
			EASCII.Null:EXIT;
			EASCII.DoubleQoute:
				IF checkNoBackSlash(checkPos:=posBuffer) THEN
					EXIT;
				ELSE
					name			:=		name - 1;
				END_IF
		END_CASE
		name^						:=		posBuffer^;
		name						:=		name + 1;
		posBuffer					:=		posBuffer + 1;
		lenMax						:=		lenMax - 1;
	END_WHILE
	len								:=		TO_WORD(posBuffer - lastKeyStart - 1);
	name^							:=		EASCII.Null;
	readKeyName						:=		TRUE;
END_IF