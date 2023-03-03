{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Reads a UValue from a struct
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_readUValue : UValue
VAR_INPUT
	valueType		:EValueType;	//Type of value
	reader			:ITF_StructReaderBase;	//Reader
END_VAR
!__IMPLEMENTATION__!
CASE valueType OF
	EValueType.none:
		FU_readUValue.signed64		:=		0;
	EValueType.digital:
		FU_readUValue.digital		:=		reader.readBool();
	EValueType.signed32,EValueType.enum:
		FU_readUValue.signed32		:=		reader.readDint();
	EValueType.signed64:
		FU_readUValue.signed64		:=		reader.readLint();
	EValueType.unsigned32:
		FU_readUValue.unsigned32	:=		reader.readDword();
	EValueType.unsigned64:
		FU_readUValue.unsigned64	:=		reader.readLword();
	EValueType.float32:
		FU_readUValue.float32		:=		reader.readReal();
END_CASE