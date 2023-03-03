{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
FUNCTION FU_dynamicUIDArrayToStruct : SLMResult
VAR_INPUT
	dynArrHandler		:REFERENCE TO FB_DynamicArray;
	writer				:ITF_StructWriterBase;
END_VAR
VAR
	i					:WORD;
	buffer				:AModuleUID;
END_VAR
!__IMPLEMENTATION__!
writer.arrayStart(singleLine:=TRUE);
IF dynArrHandler.S_lenght > 0 THEN
	FOR i := 0 TO dynArrHandler.S_lenght - 1 DO
		dynArrHandler.getElementByIndex(element:=ADR(buffer),elementSize:=SIZEOF(buffer),index:=i);
		writer.writeDint(value:=buffer);
	END_FOR
END_IF
writer.structEnd();