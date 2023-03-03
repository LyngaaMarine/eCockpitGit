FUNCTION FU_dynamicModuleArrayToStruct : SLMResult
VAR_INPUT
	dynArrHandler		:REFERENCE TO FB_DynamicArray;
	writer				:ITF_StructWriterBase;
END_VAR
VAR
	i					:WORD;
	buffer				:POINTER TO FB_Module;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.arrayStart(singleLine:=TRUE);
IF dynArrHandler.S_lenght > 0 THEN
	FOR i := 0 TO dynArrHandler.S_lenght - 1 DO
		dynArrHandler.getElementByIndex(element:=ADR(buffer),elementSize:=SIZEOF(buffer),index:=i);
		writer.writeDint(value:=buffer^._UID);
	END_FOR
END_IF
writer.structEnd();