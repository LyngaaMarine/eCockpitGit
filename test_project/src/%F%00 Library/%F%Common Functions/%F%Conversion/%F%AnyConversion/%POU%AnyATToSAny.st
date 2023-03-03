//This converts a pointer and a type to a sany
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-12-19 | Creation
FUNCTION AnyATToSAny : SAny
VAR_INPUT
	pVal		:POINTER TO USysTypes;	//Address of value
	eType		:ESysType;				//Type of value
END_VAR
(*%!%__DELIMITER__%!%*)
AnyATToSAny.eType		:=		eType;
AnyATToSAny.pVal		:=		pVal;