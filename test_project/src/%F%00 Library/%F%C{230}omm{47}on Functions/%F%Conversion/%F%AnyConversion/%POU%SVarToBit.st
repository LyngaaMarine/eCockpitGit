{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function get the bit value from a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-01-19 | Creation
FUNCTION SVarToBit : BOOL
VAR_INPUT
	sVar	:SVar;		//Variable to get bit value from
END_VAR
!__IMPLEMENTATION__!
CASE sVar.bOffset OF
	1..8:	SVarToBit		:=		(sVar.sAny.pVal^.bBYTE AND SHL(1,sVar.bOffset-1)) <> 0;
	9..16:	SVarToBit		:=		(sVar.sAny.pVal^.bWORD AND SHL(1,sVar.bOffset-1)) <> 0;
	17..32:	SVarToBit		:=		(sVar.sAny.pVal^.bDWORD AND SHL(1,sVar.bOffset-1)) <> 0;
END_CASE
