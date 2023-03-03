{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD processConfigEvent
VAR_INPUT
	client			:POINTER TO FB_DataServerClient;
	module			:POINTER TO FB_Module;
	mid				:AMessageID;
	data			:POINTER TO EASCII;
	dataLen			:DWORD;
END_VAR
VAR
	reader			:FB_JSONReader;
	result			:SLMResult;
END_VAR
!__IMPLEMENTATION__!
result						:=		reader.initialize(buffer:=data,bufferSize:=dataLen);
IF result.success THEN
	IF reader.selectedType = EStructType.object THEN
		result				:=		changeModuleConfig(module:=module,client:=client,reader:=reader,duringCreation:=FALSE);
	ELSE
		result.success		:=		FALSE;
		result.code			:=		ERCodes.ModuleManager_processMangementEvent;
		result.reason		:=		GTErrors.EwrongDataType;
	END_IF
END_IF
IF NOT(result.success) THEN
	IF client <> 0 THEN
		S_commander.writeReset();
		S_commander.writeAddTypeCode(char:=EASCII.BigS);
		S_commander.writeAddTypeCode(char:=EASCII.BigC);
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
ELSE
	saveModule(module:=module,dontLog:=FALSE);
	updateClients(module:=module,client:=client^._UID,mid:=mid);
END_IF