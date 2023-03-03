//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToTOD : TOD
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToTOD			:=		sAny.pVal^.bTOD;
	ESysType.tLTIME:
		SAnyToTOD			:=		TO_TOD(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE