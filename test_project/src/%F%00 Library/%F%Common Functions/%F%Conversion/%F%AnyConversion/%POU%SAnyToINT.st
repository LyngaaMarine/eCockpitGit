//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToINT : INT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToINT			:=		TO_INT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToINT			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToINT			:=		sAny.pVal^.bSINT;
	ESysType.tINT:
		SAnyToINT			:=		sAny.pVal^.bINT;
	ESysType.tDINT:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToINT			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToINT			:=		TO_INT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToINT			:=		TO_INT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE
