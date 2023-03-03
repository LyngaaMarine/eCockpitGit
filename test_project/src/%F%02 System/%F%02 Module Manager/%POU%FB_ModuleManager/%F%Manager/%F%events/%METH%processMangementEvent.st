{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD processMangementEvent
VAR_INPUT
	event			:EManagementEvent;
	client			:AModuleUID;
	module			:AModuleUID;
	mid				:AMessageID;
	des				:AModuleDes;
	data			:POINTER TO EASCII;
	dataLen			:DWORD;
END_VAR
VAR
	reader			:FB_JSONReader;
	moduleBuffer	:POINTER TO FB_Module;
	generatedMod	:POINTER TO FB_Module;
	clientBuffer	:POINTER TO FB_DataServerClient;
	result			:SLMResult;
END_VAR
!__IMPLEMENTATION__!
IF client <> 0 THEN
	clientBuffer					:=		getModuleByUID(modUID:=client);
	IF NOT(clientBuffer^.SYS_instanceOf(des:=GMod.DesDataServerClient)) THEN
		clientBuffer				:=		0;
	END_IF
END_IF

moduleBuffer						:=		getModuleByUID(modUID:=module);
IF moduleBuffer <> 0 THEN
	CASE event OF
		EManagementEvent.Delete:
			deleteModule(moduleBuffer:=moduleBuffer,dontDeleteDir:=FALSE,dontUpdate:=FALSE,mid:=mid,client:=client);
		EManagementEvent.Config:
			processConfigEvent(client:=clientBuffer,module:=moduleBuffer,mid:=mid,data:=data,dataLen:=dataLen);
		EManagementEvent.Creation:
			processCreationEvent(client:=clientBuffer,module:=moduleBuffer,mid:=mid,des:=des,data:=data,dataLen:=dataLen);		
	END_CASE
END_IF