{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions compares two structs, if data in struct are different, then it returns true
//If the two inputs are different sizes, it will compare the amount of bits from the smallest input, to the same amount of bits on the biggest input, and ignore the rest
//FU_CompareStruct(aA:= , aB:= );
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 01-10-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_CompareAny : BOOL
VAR_INPUT
	aA				:ANY;			//Address of first struct
	aB				:ANY;			//Size of first struct in bytes
END_VAR
!__IMPLEMENTATION__!
IF aA.diSize <= aB.diSize THEN		//Smallest struct is found
	WHILE aA.diSize > 0 DO
		aA.diSize		:=		aA.diSize - 1;
		IF aA.pValue^ <> aB.pValue^ THEN	//Bytes are compared
			FU_CompareAny	:=		TRUE;
		END_IF
		aA.pValue		:=		aA.pValue + 1;
		aB.pValue		:=		aB.pValue + 1;
	END_WHILE
ELSE
	WHILE aB.diSize > 0 DO
		aB.diSize		:=		aB.diSize - 1;
		IF aA.pValue^ <> aB.pValue^ THEN	//Bytes are compared
			FU_CompareAny	:=		TRUE;
		END_IF
		aA.pValue		:=		aA.pValue + 1;
		aB.pValue		:=		aB.pValue + 1;
	END_WHILE
END_IF
