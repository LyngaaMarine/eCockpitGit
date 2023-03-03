{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, returns the lenght of a string of any size from a pointer
//Input string must be zero terminated
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-09-20 | Creation
FUNCTION FU_wLenAI : WORD
VAR_INPUT
	str			:POINTER TO EASCII;			//Input String
END_VAR
!__IMPLEMENTATION__!
IF str <> 0 THEN
	WHILE str^ <> 0 DO
		FU_wLenAI		:=		FU_wLenAI + 1;
		str				:=		str + 1;
	END_WHILE
END_IF