{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToDWORD : DWORD
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToDWORD			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToDWORD			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToDWORD			:=		sAny.pVal^.bDWORD;
	ESysType.tLWORD:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToDWORD			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToDWORD			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToDWORD			:=		sAny.pVal^.bUDINT;
	ESysType.tULINT:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToDWORD			:=		TO_DWORD(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE