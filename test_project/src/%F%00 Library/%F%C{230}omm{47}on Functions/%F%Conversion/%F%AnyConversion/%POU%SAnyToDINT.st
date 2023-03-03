{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToDINT : DINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToDINT			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToDINT			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToDINT			:=		sAny.pVal^.bSINT;
	ESysType.tINT:
		SAnyToDINT			:=		sAny.pVal^.bINT;
	ESysType.tDINT:
		SAnyToDINT			:=		sAny.pVal^.bDINT;
	ESysType.tLINT:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToDINT			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToDINT			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToDINT			:=		TO_DINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE