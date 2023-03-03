{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Reads a 3 point conversion struct from a reader
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
FUNCTION FU_moduleValue3PointFromStructWithType : BOOL
VAR_INPUT
	reader			:ITF_StructReaderBase;			//Reader
END_VAR
VAR_IN_OUT
	data			:SModuleValueConversion3Point;	//3 Point conversion struct
END_VAR

!__IMPLEMENTATION__!
IF reader.valueType = EStructType.object THEN
	reader.enterObjectArray();
	IF reader.findKey(name:=GTSmall.Suid) <> EStructType.none THEN
		data.moduleUID			:=		reader.readWord();
		IF reader.findKey(name:=GTSmall.Smin) = EStructType.tArray THEN
			FU_readUValueWithType(value=>data.minValue,reader:=reader);
		END_IF		
		IF reader.findKey(name:=GTSmall.Smid) = EStructType.tArray THEN
			FU_readUValueWithType(value=>data.midValue,reader:=reader);
		END_IF
		IF reader.findKey(name:=GTSmall.Smax) = EStructType.tArray THEN
			FU_readUValueWithType(value=>data.maxValue,reader:=reader);
		END_IF		
	END_IF
	reader.exitObjectArray();	
END_IF