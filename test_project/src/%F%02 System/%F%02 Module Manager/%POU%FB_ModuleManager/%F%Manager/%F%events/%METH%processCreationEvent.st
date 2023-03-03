METHOD processCreationEvent
VAR_INPUT
	client			:POINTER TO FB_DataServerClient;
	module			:POINTER TO FB_Module;
	mid				:AMessageID;
	des				:AModuleDes;
	data			:POINTER TO EASCII;
	dataLen			:DWORD;
END_VAR
VAR
	i						:AModuleUID;
	reader					:FB_JSONReader;
	generatedMod			:POINTER TO FB_Module;
	result					:SLMResult;
	amountModuleBuffer		:AModuleUID;
END_VAR
(*%!%__DELIMITER__%!%*)
//If initial config data is provided, it is applied
result								:=		reader.initialize(buffer:=data,bufferSize:=dataLen);
IF processCreationEventError(client:=client,result:=result,mid:=mid) THEN
	RETURN;
ELSIF reader.selectedType <> EStructType.object THEN
	result.success					:=		FALSE;
	result.code						:=		ERCodes.ModuleManager_processMangementEvent;
	result.reason					:=		GTErrors.EwrongDataType;
	processCreationEventError(client:=client,result:=result,mid:=mid);
	RETURN;
END_IF

//Module is generated from its parent
result								:=		module^.SYS_generateSubModule(des:=des,module=>generatedMod);
IF generatedMod = 0 THEN
	result.success					:=		FALSE;
	result.code						:=		ERCodes.ModuleManager_addModuleShared;
	result.reason					:=		GTErrors.EunknownDesignator;
END_IF
IF processCreationEventError(client:=client,result:=result,mid:=mid) THEN
	RETURN;
END_IF

//Access is copied from parent
generatedMod^._access.asStruct		:=		module^._access.asStruct;

//Checks for sub module limit
IF module^._amountChildren >= GConstants.maxSubModules THEN
	result.success					:=		FALSE;
	result.code						:=		ERCodes.ModuleManager_addModuleShared;
	result.reason					:=		GTErrors.EmaxSubmodulesReached;
	FU_SafeDelete(pMem:=generatedMod);
	processCreationEventError(client:=client,result:=result,mid:=mid);
	RETURN;
ELSE
	generatedMod^._SID				:=		module^._amountChildren + 1;
END_IF

//Module is registered with parent
result								:=		setModuleParent(module:=generatedMod,newParent:=module);
IF processCreationEventError(client:=client,result:=result,mid:=mid) THEN
	FU_SafeDelete(pMem:=generatedMod);
	RETURN;
END_IF

//UID is generated and checked
generatedMod^._UID					:=		getNextFreeUID();
IF generatedMod^._UID = 0 THEN
	result.success					:=		FALSE;
	result.code						:=		ERCodes.ModuleManager_addModuleShared;
	result.reason					:=		GTErrors.EnoMoreUIDsAvailable;
	setModuleParent(module:=generatedMod,newParent:=0);
	FU_SafeDelete(pMem:=generatedMod);
	processCreationEventError(client:=client,result:=result,mid:=mid);
	RETURN;
END_IF

//No file method is run
generatedMod^.SYS_noFile();

//Initial data is loaded into module
result								:=		changeModuleConfig(module:=generatedMod,client:=client,reader:=reader,duringCreation:=TRUE);
IF processCreationEventError(client:=client,result:=result,mid:=mid) THEN
	deleteModule(moduleBuffer:=generatedMod,dontDeleteDir:=FALSE,dontUpdate:=TRUE,mid:=mid,client:=client^._UID);
	RETURN;
END_IF

//Adds module to module list
registerModuleByUID(module:=generatedMod);
//Adds module to ordered array
addToOrderedList(module:=generatedMod);

amountModuleBuffer 					:=		S_modulesAmount;
//Module creation method is run
result								:=		generatedMod^.SYS_constructor(boot:=FALSE);
IF NOT(result.success) THEN
	deleteModule(moduleBuffer:=generatedMod,dontDeleteDir:=FALSE,dontUpdate:=TRUE,mid:=mid,client:=client^._UID);
	RETURN;
END_IF

result								:=		generatedMod^.SYS_addSubModules(boot:=FALSE);
IF processCreationEventError(client:=client,result:=result,mid:=mid) THEN
	deleteModule(moduleBuffer:=generatedMod,dontDeleteDir:=FALSE,dontUpdate:=TRUE,mid:=mid,client:=client^._UID);
	RETURN;
END_IF

saveModule(module:=generatedMod,dontLog:=FALSE);
updateClients(module:=generatedMod,mid:=mid,client:=client^._UID);

IF S_modulesAmount > amountModuleBuffer THEN
	FOR i := amountModuleBuffer + 1 TO S_modulesAmount DO
		saveModule(module:=S_modulesInOrder[i],dontLog:=FALSE);
		updateClients(module:=S_modulesInOrder[i],mid:=mid,client:=client^._UID);
	END_FOR
END_IF