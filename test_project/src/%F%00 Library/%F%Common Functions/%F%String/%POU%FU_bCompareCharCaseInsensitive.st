//This function compares two characters, and ignores case
// returns true if characters are the same
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-03-22 | Creation
FUNCTION FU_bCompareCharCaseInsensitive : BOOL
VAR_INPUT
	char1		:EASCII;
	char2		:EASCII;
END_VAR
(*%!%__DELIMITER__%!%*)
IF char1 = char2 THEN
	FU_bCompareCharCaseInsensitive							:=		TRUE;
ELSE
	CASE char1 OF
		EASCII.BigA..EASCII.BigZ,EASCII.Smalla..EASCII.Smallz:
			CASE char2 OF
				EASCII.BigA..EASCII.BigZ,EASCII.Smalla..EASCII.Smallz:
					char1.5									:=		NOT(char1.5);
					IF char1 = char2 THEN
						FU_bCompareCharCaseInsensitive		:=		TRUE;
					END_IF
			END_CASE		
	END_CASE
END_IF