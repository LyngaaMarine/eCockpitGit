//This function converts any type from the type and address to a dint
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToREAL : REAL
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToREAL			:=		sAny.pVal^.bREAL;
	ESysType.tLREAL:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToREAL			:=		TO_REAL(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE