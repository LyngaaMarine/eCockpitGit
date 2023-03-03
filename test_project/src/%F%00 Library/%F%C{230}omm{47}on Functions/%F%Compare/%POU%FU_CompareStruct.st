{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions compares two structs, if data in struct are different, then it returns true 
//FU_CompareStruct(pStructA:= ADR(StructA), uiSizeA:= SIZEOF(StructA), pStructB:= ADR(StructB), uiSizeB:= SIZEOF(StructB));
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 20-12-17 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_CompareStruct : bool
VAR_INPUT
	pStructA		:POINTER TO BYTE;		//Address of first struct
	uiSizeA			:UINT;					//Size of first struct in bytes
	pStructB		:POINTER TO BYTE;		//Address of second struct
	uiSizeB			:UINT;					//Size of second struct in bytes
END_VAR
VAR
	FOR1			:WORD;
	LowestSize		:WORD;					//Keeps track of which struct is the smallest, if there is a difference
END_VAR
!__IMPLEMENTATION__!
IF uiSizeA < uiSizeB THEN		//Smallest struct is found
	LowestSize		:=		uiSizeA;
ELSE
	LowestSize		:=		uiSizeB;
END_IF
WHILE LowestSize > 0 DO
	LowestSize		:=		LowestSize - 1;
	IF pStructA^ <> pStructB^ THEN	//Bytes are compared
		FU_CompareStruct	:=		TRUE;
	END_IF
	pStructA		:=		pStructA + 1;
	pStructB		:=		pStructB + 1;
END_WHILE
