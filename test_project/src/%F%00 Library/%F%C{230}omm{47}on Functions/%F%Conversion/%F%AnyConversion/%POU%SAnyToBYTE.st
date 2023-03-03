{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToBYTE : BYTE
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToBYTE			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToBYTE			:=		TO_BYTE(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE
