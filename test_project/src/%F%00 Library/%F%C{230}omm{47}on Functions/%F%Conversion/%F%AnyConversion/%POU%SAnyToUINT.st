{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToUINT : UINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToUINT			:=		sAny.pVal^.bBYTE;
	ESysType.tWORD:
		SAnyToUINT			:=		sAny.pVal^.bWORD;
	ESysType.tDWORD:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bSINT);
	ESysType.tINT:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToUINT			:=		sAny.pVal^.bUSINT;
	ESysType.tUINT:
		SAnyToUINT			:=		sAny.pVal^.bUINT;
	ESysType.tUDINT:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToUINT			:=		TO_UINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE