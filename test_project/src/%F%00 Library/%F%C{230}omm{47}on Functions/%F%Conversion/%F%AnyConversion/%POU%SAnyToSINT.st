{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts any type from the type and address to a real
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION SAnyToSINT : SINT
VAR_INPUT
	sAny		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sAny.eType OF
	ESysType.tBOOL:		//Bool conversion
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bBOOL);
	ESysType.tBYTE:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bBYTE);
	ESysType.tWORD:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bWORD);
	ESysType.tDWORD:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bDWORD);
	ESysType.tLWORD:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bLWORD);
	ESysType.tSINT:
		SAnyToSINT			:=		sAny.pVal^.bSINT;
	ESysType.tINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bINT);
	ESysType.tDINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bDINT);
	ESysType.tLINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bLINT);
	ESysType.tUSINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bUSINT);
	ESysType.tUINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bUINT);
	ESysType.tUDINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bUDINT);
	ESysType.tULINT:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bULINT);
	ESysType.tREAL:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bREAL);
	ESysType.tLREAL:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bLREAL);
	ESysType.tSTRING:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bSTRING);
	ESysType.tTIME:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bTIME);
	ESysType.tDATE:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bDATE);
	ESysType.tDT:	
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bDT);
	ESysType.tTOD:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bTOD);
	ESysType.tLTIME:
		SAnyToSINT			:=		TO_SINT(sAny.pVal^.bLTIME);
ELSE
	RETURN;
END_CASE