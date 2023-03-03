//This function calculates the difference between two values, and outputs it positively
//
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 02-08-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_dwDiff : DWORD
VAR_INPUT
	A			:DWORD;
	B			:DWORD;
END_VAR

(*%!%__DELIMITER__%!%*)
IF A > B THEN
	FU_dwDiff			:=		A - B;
ELSE
	FU_dwDiff			:=		B - A;
END_IF