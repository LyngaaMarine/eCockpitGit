{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Writes a UValue into a struct
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_writeUValue : BOOL
VAR_INPUT
	value			:UValue;		//Value to write
	valueType		:EValueType;	//Type of value
	writer			:ITF_StructWriterBase;	//Writer
END_VAR
!__IMPLEMENTATION__!
CASE valueType OF
	EValueType.none:
		writer.writeNull();
	EValueType.digital:
		writer.writeBool(value:=value.digital);
	EValueType.signed32,EValueType.enum:
		writer.writeDint(value:=value.signed32);
	EValueType.signed64:
		writer.writeLint(value:=value.signed64);
	EValueType.unsigned32:
		writer.writeDword(value:=value.unsigned32);
	EValueType.unsigned64:
		writer.writeLword(value:=value.unsigned64);
	EValueType.float32:
		writer.writeReal(value:=value.float32);
END_CASE