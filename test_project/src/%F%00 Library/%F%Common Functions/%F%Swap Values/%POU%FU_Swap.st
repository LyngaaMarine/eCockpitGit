//This function swaps two values
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 21-03-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_Swap : BOOL
VAR_INPUT
	A		:ANY;		//Value a to be swapped with b, this is the 
	B		:ANY;		//Value b to be swapped with a 
END_VAR
VAR
	C		:BYTE;		//Holding variable
END_VAR
(*%!%__DELIMITER__%!%*)
WHILE A.diSize > 0 DO
	C			:=		A.pValue^;
	A.pValue^	:=		B.pValue^;
	B.pValue^	:=		C;
	A.diSize	:=		A.diSize - 1;
	A.pValue	:=		A.pValue + 1;
	B.pValue	:=		B.pValue + 1;
END_WHILE