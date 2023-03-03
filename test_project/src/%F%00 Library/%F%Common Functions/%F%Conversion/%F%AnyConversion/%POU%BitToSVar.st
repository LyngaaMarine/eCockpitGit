//This function get the bit value from a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-01-19 | Creation
FUNCTION BitToSVar : BOOL
VAR_INPUT
	xBit	:BOOL;		//Bool to set
	sVar	:SVar;		//Variable to get bit value from
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sVar.bOffset OF
	1..8:	sVar.sAny.pVal^.bBYTE	:=		(sVar.sAny.pVal^.bBYTE AND NOT(SHL(TO_BYTE(1),sVar.bOffset-1))) OR (SHL(TO_BYTE(xBit),sVar.bOffset-1));
	9..16:	sVar.sAny.pVal^.bWORD	:=		(sVar.sAny.pVal^.bWORD AND NOT(SHL(TO_WORD(1),sVar.bOffset-1))) OR (SHL(TO_WORD(xBit),sVar.bOffset-1));
	17..32:	sVar.sAny.pVal^.bDWORD	:=		(sVar.sAny.pVal^.bDWORD AND NOT(SHL(TO_DWORD(1),sVar.bOffset-1))) OR (SHL(TO_DWORD(xBit),sVar.bOffset-1));
END_CASE
