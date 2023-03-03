//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToUDINT : UDINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToUDINT			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToUDINT			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToUDINT			:=		sAny.pVal^.bDWORD;
	ESysType.tLWORD:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToUDINT			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToUDINT			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToUDINT			:=		sAny.pVal^.bUDINT;
	ESysType.tULINT:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToUDINT			:=		TO_UDINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE