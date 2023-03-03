//This packs an SResult into a struct
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 05-11-20 | Creation
FUNCTION FU_SLMResultToStruct : SLMResult;
VAR_INPUT
	result		:SLMResult;
	writer		:ITF_StructWriterBase;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.objectStart(singleLine:=TRUE);
	writer.addKey(name:=GTSmall.Ssuccess);
	writer.writeBool(value:=result.success);
	writer.addKey(name:=GTSmall.Scode);
	writer.writeDint(value:=result.code);
	writer.addKey(name:=GTSmall.Sreason);
	writer.writeString(value:=result.reason);
writer.structEnd();