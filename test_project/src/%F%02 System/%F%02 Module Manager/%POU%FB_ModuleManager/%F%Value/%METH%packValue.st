METHOD packValue : SLMResult
VAR_INPUT
	modID		:AModuleUID;
	writer		:ITF_StructWriterBase;
END_VAR
VAR
	modBuff		:POINTER TO FB_Module;	//General Reference
END_VAR
(*%!%__DELIMITER__%!%*)
modBuff				:=		GMod.modMan.getModuleByUID(ModUID:=modID);
IF modBuff <> 0 THEN
	moduleValueWriteToStruct(module:=modBuff,writer:=writer);
ELSE
	writer.writeNull();
END_IF