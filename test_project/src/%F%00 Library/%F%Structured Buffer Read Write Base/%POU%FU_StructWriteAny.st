//This method allows for writing variables of unknown type, or struct enums
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 21-09-20 | Creation
FUNCTION FU_StructWriteAny : BOOL
VAR_INPUT
	value		:ANY;					//Value to read
	writer		:ITF_StructWriterBase;	//Writing system
	overwrite	:ESysType;				//Type override, set to ESysType.tAny to use automatic
END_VAR
VAR
	pValue		:POINTER TO USysTypes := value.pValue;
END_VAR
(*%!%__DELIMITER__%!%*)
IF overwrite <> ESysType.tANY THEN
	value.TypeClass		:=		ESysType.tANY;
END_IF
CASE value.TypeClass OF
	ESysType.tBOOL:
		writer.writeBool(value:=pValue^.bBOOL);
	ESysType.tBYTE,ESysType.tUSINT:
		writer.writeDint(value:=pValue^.bBYTE);
	ESysType.tSINT:
		writer.writeDint(value:=pValue^.bSINT);
		
	ESysType.tWORD,ESysType.tUINT:
		writer.writeDint(value:=pValue^.bWORD);
	ESysType.tINT:
		writer.writeDint(value:=pValue^.bINT);
	
	ESysType.tDWORD,ESysType.tUDINT:
		writer.writeDword(value:=pValue^.bDWORD);
	ESysType.tDINT:
		writer.writeDint(value:=pValue^.bDINT);

	ESysType.tSTRING:
		writer.writeString(value:=value.pValue);

	ESysType.tREAL:
		writer.writeReal(value:=pValue^.bREAL);
END_CASE