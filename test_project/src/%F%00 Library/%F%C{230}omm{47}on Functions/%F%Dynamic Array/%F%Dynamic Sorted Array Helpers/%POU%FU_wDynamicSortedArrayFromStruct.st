{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
FUNCTION FU_wDynamicSortedArrayFromStruct : SLMResult
VAR_INPUT
	dynArr				:REFERENCE TO FB_wDynamicSortedArray;
	reader				:ITF_StructReaderBase;
END_VAR
VAR
	length				:WORD;
	i					:WORD;
END_VAR
!__IMPLEMENTATION__!
IF reader.valueType = EStructType.tArray THEN
	dynArr.empty();
	reader.enterObjectArray();
	length												:=		reader.amountInSelection;
	FU_wDynamicSortedArrayFromStruct					:=		dynArr.allocate(size:=length);
	IF FU_wDynamicSortedArrayFromStruct.success AND length > 0 THEN
		FOR i := 1 TO length DO
			IF reader.nextArray() <> EStructType.none THEN
				FU_wDynamicSortedArrayFromStruct		:=		dynArr.addElement(element:=reader.readWord());
				IF NOT(FU_wDynamicSortedArrayFromStruct.success) THEN
					EXIT;
				END_IF
			ELSE
				EXIT;				
			END_IF
		END_FOR		
	END_IF
	reader.exitObjectArray();	
END_IF