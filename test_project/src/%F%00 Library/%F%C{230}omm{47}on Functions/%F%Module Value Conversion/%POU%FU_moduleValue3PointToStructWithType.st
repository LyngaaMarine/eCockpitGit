{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Writes a 3 point conversion struct to a writer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
FUNCTION FU_moduleValue3PointToStructWithType : BOOL
VAR_INPUT
	writer			:ITF_StructWriterBase;			//Writer
END_VAR
VAR_IN_OUT
	data			:SModuleValueConversion3Point;	//3 Point conversion struct
END_VAR
VAR
	module			:AModule;
	valueType		:EValueType;
END_VAR

!__IMPLEMENTATION__!
writer.objectStart(singleLine:=TRUE);
writer.addKey(name:=GTSmall.Suid);
writer.writeDint(value:=data.moduleUID);
module				:=		GMod.modMan.getModuleByUID(modUID:=data.moduleUID);
IF module <> 0 THEN
	valueType		:=		module^.SYS_valueType;
	writer.addKey(name:=GTSmall.Smin);
	FU_writeUValueWithType(value:=data.minValue,valueType:=valueType,writer:=writer);
	writer.addKey(name:=GTSmall.Smid);
	FU_writeUValueWithType(value:=data.midValue,valueType:=valueType,writer:=writer);
	writer.addKey(name:=GTSmall.Smax);
	FU_writeUValueWithType(value:=data.maxValue,valueType:=valueType,writer:=writer);
END_IF
writer.structEnd();