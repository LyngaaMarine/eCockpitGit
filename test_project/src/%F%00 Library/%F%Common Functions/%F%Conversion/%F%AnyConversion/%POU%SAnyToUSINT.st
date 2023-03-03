//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToUSINT : USINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToUSINT			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToUSINT			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToUSINT			:=		TO_USINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE