FUNCTION FU_dynamicWordArrayFromStruct : SLMResult
VAR_INPUT
	dynArrHandler		:REFERENCE TO FB_DynamicArray;
	reader				:ITF_StructReaderBase;
END_VAR
VAR
	length				:WORD;
	i					:WORD;
	buffer				:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF reader.valueType = EStructType.tArray THEN
	dynArrHandler.empty();
	reader.enterObjectArray();
	length										:=		reader.amountInSelection;
	FU_dynamicWordArrayFromStruct				:=		dynArrHandler.allocate(size:=length);
	IF FU_dynamicWordArrayFromStruct.success AND length > 0 THEN
		FOR i := 1 TO length DO
			IF reader.nextArray() <> EStructType.none THEN
				buffer							:=		reader.readWord();				
				FU_dynamicWordArrayFromStruct	:=		dynArrHandler.appendElement(element:=ADR(buffer),elementSize:=SIZEOF(buffer));
				IF NOT(FU_dynamicWordArrayFromStruct.success) THEN
					EXIT;
				END_IF
			ELSE
				EXIT;				
			END_IF
		END_FOR		
	END_IF
	reader.exitObjectArray();
END_IF