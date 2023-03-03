{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToTIME : TIME
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToTIME			:=		sAny.pVal^.bTIME;
	ESysType.tDATE:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToTIME			:=		TO_TIME(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE