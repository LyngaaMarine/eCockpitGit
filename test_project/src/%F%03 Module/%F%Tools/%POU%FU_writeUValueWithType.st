//Writes a UValue into a struct with the type
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_writeUValueWithType : BOOL
VAR_INPUT
	value			:UValue;		//Value to write
	valueType		:EValueType;	//Type of value
	writer			:ITF_StructWriterBase;	//Writer
END_VAR
(*%!%__DELIMITER__%!%*)
writer.arrayStart(singleLine:=TRUE);
FU_writeValueType(valueType:=valueType,writer:=writer);
FU_writeUValue(value:=value,valueType:=valueType,writer:=writer);
writer.structEnd();