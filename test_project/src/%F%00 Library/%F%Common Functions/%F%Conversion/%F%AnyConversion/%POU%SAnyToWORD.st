//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToWORD : WORD
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToWORD			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToWORD			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToWORD			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToWORD			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToWORD			:=		TO_WORD(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE