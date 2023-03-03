//This function swaps two values
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 21-03-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_SwapAT : BOOL
VAR_INPUT
	A		:POINTER TO BYTE;		//Value a to be swapped with b,
	B		:POINTER TO BYTE;		//Value b to be swapped with a 
	Size	:DINT;
END_VAR
VAR
	C		:BYTE;					//Holding variable
END_VAR
(*%!%__DELIMITER__%!%*)
WHILE Size > 0 DO
	C		:=		A^;
	A^		:=		B^;
	B^		:=		C;
	Size	:=		Size - 1;
	A		:=		A + 1;
	B		:=		B + 1;
END_WHILE