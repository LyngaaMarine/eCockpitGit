{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToLWORD : LWORD
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToLWORD			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToLWORD			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToLWORD			:=		sAny.pVal^.bDWORD;
	ESysType.tLWORD:
		SAnyToLWORD			:=		sAny.pVal^.bLWORD;
	ESysType.tSINT:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToLWORD			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToLWORD			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToLWORD			:=		sAny.pVal^.bUDINT;
	ESysType.tULINT:
		SAnyToLWORD			:=		sAny.pVal^.bULINT;
	ESysType.tREAL:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToLWORD			:=		TO_LWORD(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE