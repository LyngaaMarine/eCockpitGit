//This function converts any variable to a sany
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-12-19 | Creation
FUNCTION AnyToSAny : SAny
VAR_INPUT
	aAnyIn	:ANY;
END_VAR
(*%!%__DELIMITER__%!%*)
AnyToSAny.eType		:=		TO_BYTE(aAnyIn.TypeClass);
AnyToSAny.pVal		:=		aAnyIn.pValue;