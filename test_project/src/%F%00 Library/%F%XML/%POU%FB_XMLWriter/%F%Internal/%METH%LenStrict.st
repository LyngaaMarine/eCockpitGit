{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This Method, returns the lenght of a string from a pointer by counting up to the first 0 byte in the string
//It is strict meaning it will skip some characters
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 06-06-18 | Creation
// | 2         | NSN      | 08-06-18 | Exclamation point added to illigal characters
METHOD PROTECTED LenStrict : DWORD
VAR_INPUT
	pString		:POINTER TO BYTE;	//Address of the string
END_VAR
!__IMPLEMENTATION__!
IF pString <> 0 THEN
	WHILE pString^ <> 0 DO
		IF NOT(pString^ = EASCII.Space OR pString^ = EASCII.LessThan OR pString^ = EASCII.GreatThan OR pString^ = EASCII.DoubleQoute OR pString^ = EASCII.Equal OR pString^ = EASCII.Apostrophe OR pString^ = EASCII.Ampersand OR pString^ = EASCII.Exclamation) THEN	//Illegal charaters are skipped
			LenStrict			:=		LenStrict + 1;
		END_IF
		pString					:=		pString + 1;
	END_WHILE
END_IF
