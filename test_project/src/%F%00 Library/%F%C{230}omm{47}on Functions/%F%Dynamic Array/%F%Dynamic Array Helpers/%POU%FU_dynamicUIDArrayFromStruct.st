{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
FUNCTION FU_dynamicUIDArrayFromStruct : SLMResult
VAR_INPUT
	dynArrHandler		:REFERENCE TO FB_DynamicArray;
	reader				:ITF_StructReaderBase;
END_VAR
VAR
	length				:WORD;
	i					:WORD;
	buffer				:AModuleUID;
END_VAR
!__IMPLEMENTATION__!
IF reader.valueType = EStructType.tArray THEN
	dynArrHandler.empty();
	reader.enterObjectArray();
	length											:=		reader.amountInSelection;
	FU_dynamicUIDArrayFromStruct					:=		dynArrHandler.allocate(size:=length);
	IF FU_dynamicUIDArrayFromStruct.success AND length > 0 THEN
		FOR i := 1 TO length DO
			IF reader.nextArray() <> EStructType.none THEN
				buffer								:=		reader.readWord();
				FU_dynamicUIDArrayFromStruct		:=		dynArrHandler.appendElement(element:=ADR(buffer),elementSize:=SIZEOF(buffer));
				IF NOT(FU_dynamicUIDArrayFromStruct.success) THEN
					EXIT;
				END_IF				
			ELSE
				EXIT;				
			END_IF
		END_FOR		
	END_IF
	reader.exitObjectArray();	
END_IF