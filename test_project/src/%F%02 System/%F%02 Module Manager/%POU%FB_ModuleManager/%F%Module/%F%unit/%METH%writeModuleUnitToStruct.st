//Method for writing module name to writer
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-05-21 | Creation
METHOD writeModuleUnitToStruct : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	writer		:ITF_StructWriterBase;
	mode		:BYTE;
END_VAR
VAR
	unit		:AModuleUnit;
END_VAR
(*%!%__DELIMITER__%!%*)
CASE mode OF
	0:	//Name Formatted
		unit			:=		getModuleUnit(module:=module,layer:=0);
	1:	//Name Raw
		IF module^._unit <> 0 THEN
			unit		:=		module^._unit^;
		END_IF
ELSE
	RETURN;
END_CASE
writer.writeString(value:=ADR(unit));