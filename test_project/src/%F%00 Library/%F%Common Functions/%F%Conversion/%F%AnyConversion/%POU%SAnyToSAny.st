//This function converts any type from the type and address to any type
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-12-18 | Creation
FUNCTION SAnyToSAny : BOOL
VAR_INPUT
	sAnyIn	:SAny;
	sAnyOut	:SAny;
END_VAR
(*%!%__DELIMITER__%!%*)
CASE sAnyOut.eType OF
	ESysType.tBOOL:		//Bool conversion
		sAnyOut.pVal^.bBOOL		:=		SAnyToBOOL(sAny:=sAnyIn);
	ESysType.tBYTE:
		sAnyOut.pVal^.bBYTE		:=		SAnyToBYTE(sAny:=sAnyIn);
	ESysType.tWORD:
		sAnyOut.pVal^.bWORD		:=		SAnyToWORD(sAny:=sAnyIn);
	ESysType.tDWORD:
		sAnyOut.pVal^.bDWORD	:=		SAnyToDWORD(sAny:=sAnyIn);
	ESysType.tLWORD:
		sAnyOut.pVal^.bLWORD	:=		SAnyToLWORD(sAny:=sAnyIn);
	ESysType.tSINT:
		sAnyOut.pVal^.bSINT		:=		SAnyToSINT(sAny:=sAnyIn);
	ESysType.tINT:
		sAnyOut.pVal^.bINT		:=		SAnyToINT(sAny:=sAnyIn);
	ESysType.tDINT:
		sAnyOut.pVal^.bDINT		:=		SAnyToDINT(sAny:=sAnyIn);
	ESysType.tLINT:
		sAnyOut.pVal^.bLINT		:=		SAnyToLINT(sAny:=sAnyIn);
	ESysType.tUSINT:
		sAnyOut.pVal^.bUSINT	:=		SAnyToUSINT(sAny:=sAnyIn);
	ESysType.tUINT:
		sAnyOut.pVal^.bUINT		:=		SAnyToUINT(sAny:=sAnyIn);
	ESysType.tUDINT:
		sAnyOut.pVal^.bUDINT	:=		SAnyToUDINT(sAny:=sAnyIn);
	ESysType.tULINT:
		sAnyOut.pVal^.bULINT	:=		SAnyToULINT(sAny:=sAnyIn);
	ESysType.tREAL:
		sAnyOut.pVal^.bREAL		:=		SAnyToREAL(sAny:=sAnyIn);
	ESysType.tLREAL:
		sAnyOut.pVal^.bLREAL	:=		SAnyToLREAL(sAny:=sAnyIn);
	ESysType.tSTRING:
		sAnyOut.pVal^.bSTRING	:=		SAnyToSTRING(sAny:=sAnyIn);
	ESysType.tTIME:
		sAnyOut.pVal^.bTIME		:=		SAnyToTIME(sAny:=sAnyIn);
	ESysType.tDATE:
		sAnyOut.pVal^.bDATE		:=		SAnyToDATE(sAny:=sAnyIn);
	ESysType.tDT:	
		sAnyOut.pVal^.bDT		:=		SAnyToDT(sAny:=sAnyIn);
	ESysType.tTOD:
		sAnyOut.pVal^.bTOD		:=		SAnyToTOD(sAny:=sAnyIn);
	ESysType.tLTIME:
		sAnyOut.pVal^.bLTIME	:=		SAnyToLTIME(sAny:=sAnyIn);
ELSE
	SAnyToSAny					:=		TRUE;
	RETURN;
END_CASE