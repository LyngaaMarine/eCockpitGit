//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToDT : DT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToDT			:=		TO_DT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToDT			:=		sAny.pVal^.bDT;
	ESysType.tTOD:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToDT			:=		TO_DT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE