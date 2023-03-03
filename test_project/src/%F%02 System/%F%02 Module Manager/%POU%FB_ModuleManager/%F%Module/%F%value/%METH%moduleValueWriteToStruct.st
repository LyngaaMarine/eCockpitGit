//Method for writing module name to writer
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-05-21 | Creation
METHOD moduleValueWriteToStruct
VAR_INPUT
	module		:POINTER TO FB_Module;
	writer		:ITF_StructWriterBase;
END_VAR
VAR
	valid		:EValueValidity;
END_VAR
(*%!%__DELIMITER__%!%*)
valid			:=		module^.SYS_isValid;
IF valid = EValueValidity.valid THEN
	CASE module^.SYS_valueType OF
		EValueType.digital:
			writer.writeDint(value:=TO_DINT(module^.SYS_valueDigital));
		EValueType.signed32,EValueType.Enum:
			writer.writeDint(value:=module^.SYS_valueSigned32);
		EValueType.unsigned32:
			writer.writeDword(value:=module^.SYS_valueUnsigned32);
		EValueType.signed64:
			writer.writeLint(value:=module^.SYS_valueSigned64);
		EValueType.unsigned64:
			writer.writeLword(value:=module^.SYS_valueUnsigned64);
	ELSE
		writer.writeReal(value:=module^.SYS_valueFloat32);
	END_CASE
ELSE
	writer.writeString(value:=GTLists.valueInvalidTypes[valid]);
END_IF