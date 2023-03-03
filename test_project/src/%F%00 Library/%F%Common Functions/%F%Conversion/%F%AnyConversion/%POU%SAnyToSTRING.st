//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToSTRING : STRING(80);
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToSTRING			:=		sAny.pVal^.bSTRING;
	ESysType.tTIME:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToSTRING			:=		TO_STRING(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE