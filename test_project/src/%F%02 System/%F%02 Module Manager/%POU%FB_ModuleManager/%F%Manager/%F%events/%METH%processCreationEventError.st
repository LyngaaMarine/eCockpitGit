{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD processCreationEventError : BOOL
VAR_INPUT
	client			:POINTER TO FB_DataServerClient;
	result			:SLMResult;
	mid				:AMessageID;
END_VAR

!__IMPLEMENTATION__!
IF NOT(result.success) THEN
	processCreationEventError		:=		TRUE;
	IF client <> 0 THEN
		S_commander.writeReset();
		S_commander.writeAddTypeCode(char:=EASCII.BigS);
		S_commander.writeAddTypeCode(char:=EASCII.BigA);
		S_commander.writeJSONInit(jsonType:=EStructType.object);
		IF mid <> 0 THEN
			S_commander.jSONWriter.addKey(name:=GTSmall.Snum);
			S_commander.jSONWriter.writeDint(value:=mid);
		END_IF
		IF client <> 0 THEN
			S_commander.jSONWriter.addKey(name:=GTSmall.Sclient);
			S_commander.jSONWriter.writeDint(value:=client^._UID);
		END_IF
		S_commander.jSONWriter.addKey(name:=GTSmall.Sresult);
		FU_SLMResultToStruct(result:=result,writer:=S_commander.jSONWriter);
		client^.sendData(commander:=S_commander);
	END_IF
END_IF