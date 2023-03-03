{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToBOOL : BOOL
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToBOOL			:=		sAny.pVal^.bBOOL;
	ESysType.tBYTE:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToBOOL			:=		TO_BOOL(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE