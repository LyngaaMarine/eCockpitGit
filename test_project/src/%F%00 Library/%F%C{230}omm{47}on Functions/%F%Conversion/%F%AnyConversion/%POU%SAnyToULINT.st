{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToULINT : ULINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToULINT			:=		TO_ULINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE