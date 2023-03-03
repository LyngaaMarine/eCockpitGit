{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method does all the shared stuff when either adding external modules or creating them dynamically
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-06-19 | Creation
METHOD registerModule : SLMResult
VAR_INPUT
	parentModule			:POINTER TO FB_Module;
	moduleBuffer			:POINTER TO FB_Module;
	subID					:AModuleUID;			//Sub id override, only use for auto loading
	mid						:AMessageID;			//Number of request, causing this event
	client					:AModuleUID;			//Client causing this event
END_VAR
VAR
	result					:SLMResult;
	uidSet					:BOOL;
END_VAR
!__IMPLEMENTATION__!
//Parent must be provided
IF parentModule = 0 THEN
	registerModule.success							:=		FALSE;
	registerModule.code								:=		ERCodes.ModuleManager_addModuleShared;
	FU_SafeDelete(pMem:=moduleBuffer);
	RETURN;
END_IF

//Actions for post boot module addition
IF S_loadDone THEN
	//Checks for sub module limit
	IF parentModule^._amountChildren >= GConstants.maxSubModules THEN
		registerModule.success						:=		FALSE;
		registerModule.code							:=		ERCodes.ModuleManager_addModuleShared;
		registerModule.reason						:=		ADR('Max submodules reached');
		FU_SafeDelete(pMem:=moduleBuffer);
		RETURN;
	ELSE
		moduleBuffer^._SID							:=		parentModule^._amountChildren + 1;
	END_IF
	//Module is registered with parent
	registerModule									:=		setModuleParent(module:=moduleBuffer,newParent:=parentModule);
	IF NOT(registerModule.success) THEN
		FU_SafeDelete(pMem:=moduleBuffer);
		RETURN;
	END_IF
	//UID is generated and checked
	moduleBuffer^._UID								:=		getNextFreeUID();
	IF moduleBuffer^._UID = 0 THEN
		registerModule.success						:=		FALSE;
		registerModule.code							:=		ERCodes.ModuleManager_addModuleShared;
		registerModule.reason						:=		ADR('No more UIDs left');
		setModuleParent(module:=moduleBuffer,newParent:=0);
		FU_SafeDelete(pMem:=moduleBuffer);
		RETURN;
	END_IF
	moduleBuffer^.SYS_noFile();
//Actions for during boot module additions
ELSE
	//Parent is buffered
	moduleBuffer^._parent							:=		parentModule;
	//Sub id is set, it will be overwritten if found in file
	moduleBuffer^._SID								:=		subID;
	//File is loaded from file system if it exists
	result											:=		loadModule(module:=moduleBuffer);
	IF NOT(result.success) THEN
		moduleBuffer^.SYS_noFile();
	END_IF
	//UID is checked
	IF moduleBuffer^._UID <> 0 AND S_modules[moduleBuffer^._UID] <> 0 THEN
		moduleBuffer^._UID							:=		0;
	END_IF
	//Module is added to sub-module buffer or if sub id is invalid it is added to pool of invalid sub ids
	IF S_subModulesBufferAmount + S_subModulesInvalidAmount < GConstants.maxSubModules THEN
		IF moduleBuffer^._SID > 0 AND moduleBuffer^._SID < GConstants.maxSubModules AND S_subModulesBuffer[moduleBuffer^._SID] = 0 THEN
			S_subModulesBuffer[moduleBuffer^._SID]	:=		moduleBuffer;
			S_subModulesBufferAmount				:=		S_subModulesBufferAmount + 1;
		ELSE
			S_subModulesInvalidAmount				:=		S_subModulesInvalidAmount + 1;
			S_subModulesInvalidBuffer[S_subModulesInvalidAmount]:=		moduleBuffer;
		END_IF
	ELSE
		registerModule.success						:=		FALSE;
		registerModule.code							:=		ERCodes.ModuleManager_addModuleShared;
		FU_SafeDelete(pMem:=moduleBuffer);
		RETURN;
	END_IF
END_IF

//Adds module to module list
IF moduleBuffer^._UID <> 0 THEN
	registerModuleByUID(module:=moduleBuffer);
	uidSet											:=		TRUE;
ELSE
	S_missingUID									:=		S_missingUID + 1;		
END_IF

//Adds module to ordered array
addToOrderedList(module:=moduleBuffer);

//Module creation method is run, if it fails
registerModule										:=		moduleBuffer^.SYS_constructor(boot:=NOT(S_loadDone));
IF NOT(registerModule.success) THEN
	removeFromOrderedList(module:=moduleBuffer);
	IF uidSet THEN
		deregisterModuleByUID(module:=moduleBuffer);
	END_IF
	IF S_loadDone THEN
		setModuleParent(module:=moduleBuffer,newParent:=0);
	END_IF
	FU_SafeDelete(pMem:=moduleBuffer);
	RETURN;
END_IF