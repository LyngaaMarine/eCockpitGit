//Reads a UValue from a struct with unspecified type
//Returns true if unsuccesful
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_readUValueWithType : BOOL
VAR_OUTPUT
	valueType		:EValueType;	//Type of value read
	value			:UValue;		//Value to write
END_VAR
VAR_INPUT
	reader			:ITF_StructReaderBase;	//Reader
END_VAR
(*%!%__DELIMITER__%!%*)
IF reader.valueType = EStructType.tArray THEN
	reader.enterObjectArray();
	IF reader.nextArray() = EStructType.tString THEN
		valueType				:=		FU_readValueType(reader:=reader);
		IF reader.nextArray() <> EStructType.none THEN
			value				:=		FU_readUValue(valueType:=valueType,reader:=reader);
		END_IF	END_IF
	reader.exitObjectArray();
ELSE
	FU_readUValueWithType		:=		TRUE;
END_IF
