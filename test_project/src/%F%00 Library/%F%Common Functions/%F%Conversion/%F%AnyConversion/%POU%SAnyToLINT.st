//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToLINT : LINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToLINT			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToLINT			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToLINT			:=		sAny.pVal^.bDWORD;
	ESysType.tLWORD:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToLINT			:=		sAny.pVal^.bSINT;
	ESysType.tINT:
		SAnyToLINT			:=		sAny.pVal^.bINT;
	ESysType.tDINT:
		SAnyToLINT			:=		sAny.pVal^.bDINT;
	ESysType.tLINT:
		SAnyToLINT			:=		sAny.pVal^.bLINT;
	ESysType.tUSINT:
		SAnyToLINT			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToLINT			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToLINT			:=		sAny.pVal^.bUDINT;
	ESysType.tULINT:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToLINT			:=		TO_LINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE