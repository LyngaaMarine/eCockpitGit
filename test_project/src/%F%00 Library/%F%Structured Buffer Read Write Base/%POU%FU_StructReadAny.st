{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method allows for reading variables of unknown type, or struct enums
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 21-09-20 | Creation
FUNCTION FU_StructReadAny : BOOL
VAR_INPUT
	value		:ANY;					//Value to read
	reader		:ITF_StructReaderBase;	//Reading system
	overwrite	:ESysType;				//Type override, set to ESysType.tAny to use automatic
END_VAR
VAR
	pValue		:POINTER TO USysTypes := value.pValue;
END_VAR
!__IMPLEMENTATION__!
IF overwrite = ESysType.tANY THEN
	overwrite			:=		TO_BYTE(value.TypeClass);
END_IF
CASE overwrite OF
	ESysType.tBOOL:
		pValue^.bBOOL	:=		reader.readBool();
	ESysType.tBYTE,ESysType.tUSINT:
		pValue^.bBYTE	:=		TO_BYTE(reader.readDint());
	ESysType.tSINT:
		pValue^.bSINT	:=		TO_SINT(reader.readDint());
		
	ESysType.tWORD,ESysType.tUINT:
		pValue^.bWORD	:=		TO_WORD(reader.readDint());
	ESysType.tINT:
		pValue^.bINT	:=		TO_INT(reader.readDint());
	
	ESysType.tDWORD,ESysType.tUDINT:
		pValue^.bDWORD	:=		reader.readDword();
	ESysType.tDINT:
		pValue^.bDINT	:=		reader.readDint();

	ESysType.tSTRING:
		reader.readString(str:=value.pValue,lenMax:=TO_DWORD(value.diSize - 1));

	ESysType.tREAL:
		pValue^.bREAL	:=		reader.readReal();
END_CASE