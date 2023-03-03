//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToDATE : DATE
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToDATE			:=		sAny.pVal^.bDATE;
	ESysType.tDT:	
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToDATE			:=		TO_DATE(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE