{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This Method, returns the lenght of a string from a pointer by counting up to the first 0 byte in the string
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-06-18 | Creation
METHOD PROTECTED InLength : DWORD
VAR_INPUT
	pString		:POINTER TO BYTE;	//Address of the string
END_VAR
!__IMPLEMENTATION__!
IF pString <> 0 THEN
	WHILE pString^ <> 0 DO
		InLength			:=		InLength + 1;
		pString				:=		pString + 1;
	END_WHILE
END_IF
