//This function calculates the logarithm of a value with a given base
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
FUNCTION FU_rLogN : REAL
VAR_INPUT
	base			:REAL;
	value			:REAL;
END_VAR
VAR
	logBase			:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF base <> 0 THEN
	logBase		:=		LOG(base);
END_IF
IF logBase <> 0 AND value <> 0 THEN
	FU_rLogN	:=		LOG(value) / logBase;
END_IF