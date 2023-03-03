{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts a dint to any variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-18 | Creation
FUNCTION BOOLToSAny : BOOL
VAR_INPUT
	in			:BOOL;		//Input variable
	sOut		:SAny;		//Variable information
END_VAR
!__IMPLEMENTATION__!
CASE sOut.eType OF
	ESysType.tBOOL:		//Bool conversion
		sOut.pVal^.bBOOL		:=		in;
	ESysType.tBYTE:
		sOut.pVal^.bBYTE		:=		TO_BYTE(in);
	ESysType.tWORD:
		sOut.pVal^.bWORD		:=		TO_WORD(in);
	ESysType.tDWORD:
		sOut.pVal^.bDWORD		:=		TO_DWORD(in);
	ESysType.tLWORD:
		sOut.pVal^.bLWORD		:=		TO_LWORD(in);
	ESysType.tSINT:
		sOut.pVal^.bSINT		:=		TO_SINT(in);
	ESysType.tINT:
		sOut.pVal^.bINT			:=		TO_INT(in);
	ESysType.tDINT:
		sOut.pVal^.bDINT		:=		TO_DINT(in);
	ESysType.tLINT:
		sOut.pVal^.bLINT		:=		TO_LINT(in);
	ESysType.tUSINT:
		sOut.pVal^.bUSINT		:=		TO_USINT(in);
	ESysType.tUINT:
		sOut.pVal^.bUINT		:=		TO_UINT(in);
	ESysType.tUDINT:
		sOut.pVal^.bUDINT		:=		TO_UDINT(in);
	ESysType.tULINT:
		sOut.pVal^.bULINT		:=		TO_ULINT(in);
	ESysType.tREAL:
		sOut.pVal^.bREAL		:=		TO_REAL(in);
	ESysType.tLREAL:
		sOut.pVal^.bLREAL		:=		TO_LREAL(in);
	ESysType.tSTRING:
		sOut.pVal^.bSTRING		:=		TO_STRING(in);
	ESysType.tTIME:
		sOut.pVal^.bTIME		:=		TO_TIME(in);
	ESysType.tDATE:
		sOut.pVal^.bDATE		:=		TO_DATE(in);
	ESysType.tDT:	
		sOut.pVal^.bDT			:=		TO_DT(in);
	ESysType.tTOD:
		sOut.pVal^.bTOD			:=		TO_TOD(in);
	ESysType.tLTIME:
		sOut.pVal^.bLTIME		:=		TO_LTIME(in);
ELSE
	RETURN;
END_CASE