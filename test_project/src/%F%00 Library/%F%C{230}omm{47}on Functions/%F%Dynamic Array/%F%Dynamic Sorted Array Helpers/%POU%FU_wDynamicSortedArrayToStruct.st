{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
FUNCTION FU_wDynamicSortedArrayToStruct : SLMResult
VAR_INPUT
	dynArr				:REFERENCE TO FB_wDynamicSortedArray;
	writer				:ITF_StructWriterBase;
END_VAR
VAR
	i					:WORD;
	buffer				:WORD;
END_VAR
!__IMPLEMENTATION__!
writer.arrayStart(singleLine:=TRUE);
IF dynArr.S_lenght > 0 THEN
	FOR i := 0 TO dynArr.S_lenght - 1 DO
		dynArr.getElementByIndex(index:=i,element=>buffer);
		writer.writeDint(value:=buffer);
	END_FOR
END_IF
writer.structEnd();