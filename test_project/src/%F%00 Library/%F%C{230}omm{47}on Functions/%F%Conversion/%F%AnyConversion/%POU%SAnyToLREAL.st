{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToLREAL : LREAL
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToLREAL			:=		sAny.pVal^.bREAL;
	ESysType.tLREAL:
		SAnyToLREAL			:=		sAny.pVal^.bLREAL;
	ESysType.tSTRING:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToLREAL			:=		TO_LREAL(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE