//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToLTIME : LTIME
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToLTIME			:=		TO_LTIME(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToLTIME			:=		sAny.pVal^.bLTIME;
ELSE
	RETURN;
END_CASE