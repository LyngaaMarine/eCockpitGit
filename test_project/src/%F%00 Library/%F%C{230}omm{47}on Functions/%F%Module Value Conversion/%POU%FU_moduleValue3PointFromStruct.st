{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Reads a 3 point conversion struct from a reader
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
FUNCTION FU_moduleValue3PointFromStruct : BOOL
VAR_INPUT
	reader			:ITF_StructReaderBase;			//Reader
END_VAR
VAR_IN_OUT
	data			:SModuleValueConversion3Point;	//3 Point conversion struct
END_VAR
VAR
	module			:AModule;
END_VAR

!__IMPLEMENTATION__!
IF reader.valueType = EStructType.object THEN
	reader.enterObjectArray();
	IF reader.findKey(name:=GTSmall.Suid) <> EStructType.none THEN
		module						:=		GMod.modMan.getModuleByUID(modUID:=reader.readWord());
		IF module <> 0 THEN
			data.moduleUID			:=		module^._UID;
			IF reader.findKey(name:=GTSmall.Smin) <> EStructType.none THEN
				data.minValue		:=		FU_readUValue(reader:=reader,valueType:=module^.SYS_valueType);
			END_IF		
			IF reader.findKey(name:=GTSmall.Smid) <> EStructType.none THEN
				data.midValue		:=		FU_readUValue(reader:=reader,valueType:=module^.SYS_valueType);
			END_IF
			IF reader.findKey(name:=GTSmall.Smax) <> EStructType.none THEN
				data.maxValue		:=		FU_readUValue(reader:=reader,valueType:=module^.SYS_valueType);
			END_IF
		END_IF		
	END_IF
	reader.exitObjectArray();	
END_IF