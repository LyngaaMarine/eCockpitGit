//Writes a value type to a struct
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_writeValueType : BOOL
VAR_INPUT
	valueType		:EValueType;	//Type to write
	writer			:ITF_StructWriterBase;	//Writer
END_VAR
(*%!%__DELIMITER__%!%*)
CASE valueType OF
	EValueType.none:
		writer.writeString(value:=ADR('Null'));
	EValueType.digital:
		writer.writeString(value:=ADR('DIG'));
	EValueType.enum:
		writer.writeString(value:=ADR('ENUM'));
	EValueType.signed32:
		writer.writeString(value:=ADR('SIG32'));
	EValueType.signed64:
		writer.writeString(value:=ADR('SIG64'));
	EValueType.unsigned32:
		writer.writeString(value:=ADR('UNS32'));
	EValueType.unsigned64:
		writer.writeString(value:=ADR('UNS64'));
	EValueType.float32:
		writer.writeString(value:=ADR('FLT32'));
END_CASE