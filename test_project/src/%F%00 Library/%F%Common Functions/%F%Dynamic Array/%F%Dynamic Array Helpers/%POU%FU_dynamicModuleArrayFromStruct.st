FUNCTION FU_dynamicModuleArrayFromStruct : SLMResult
VAR_INPUT
	dynArrHandler		:REFERENCE TO FB_DynamicArray;
	reader				:ITF_StructReaderBase;
END_VAR
VAR
	length				:WORD;
	i					:WORD;
	buffer				:POINTER TO FB_Module;
END_VAR
(*%!%__DELIMITER__%!%*)
IF reader.valueType = EStructType.tArray THEN
	dynArrHandler.empty();
	reader.enterObjectArray();
	length											:=		reader.amountInSelection;
	FU_dynamicModuleArrayFromStruct					:=		dynArrHandler.allocate(size:=length);
	IF FU_dynamicModuleArrayFromStruct.success AND length > 0 THEN
		FOR i := 1 TO length DO
			IF reader.nextArray() <> EStructType.none THEN
				buffer								:=		GMod.modMan.getModuleByUID(modUID:=reader.readWord());
				IF buffer <> 0 THEN
					FU_dynamicModuleArrayFromStruct	:=		dynArrHandler.appendElement(element:=ADR(buffer),elementSize:=SIZEOF(buffer));
					IF NOT(FU_dynamicModuleArrayFromStruct.success) THEN
						EXIT;
					END_IF
				END_IF				
			ELSE
				EXIT;				
			END_IF
		END_FOR		
	END_IF
	reader.exitObjectArray();	
END_IF