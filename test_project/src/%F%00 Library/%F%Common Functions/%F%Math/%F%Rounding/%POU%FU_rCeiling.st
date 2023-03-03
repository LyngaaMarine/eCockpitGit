//This function rounds the given value up to the nearest whole value
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
FUNCTION FU_rCeiling : REAL
VAR_INPUT
	rIn		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
FU_rCeiling 	:=	TO_INT(rIn);
IF FU_rCeiling < rIn THEN
	FU_rCeiling := FU_rCeiling + 1;
END_IF;