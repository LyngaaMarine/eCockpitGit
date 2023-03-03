{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method does all the shared stuff when either adding external modules or creating them dynamically
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-06-19 | Creation
METHOD registerAutoLoadedModule : SLMResult
VAR_INPUT
	moduleBuffer			:POINTER TO FB_Module;
	parentModule			:POINTER TO FB_Module;
	subID					:AModuleUID;			//Sub id override, only use for auto loading
END_VAR
VAR
	result					:SLMResult;
	uidSet					:BOOL;
END_VAR
!__IMPLEMENTATION__!
//Parent must be provided
IF moduleBuffer = 0 THEN
	registerAutoLoadedModule.success			:=		FALSE;
	registerAutoLoadedModule.code				:=		ERCodes.FB_ModuleManager_registerAutoLoadedModule;
	RETURN;
END_IF

//Parent is buffered
moduleBuffer^._parent							:=		parentModule;
//Sub id is set, it will be overwritten if found in file
moduleBuffer^._SID								:=		subID;
//File is loaded from file system if it exists
result											:=		loadModule(module:=moduleBuffer);
IF NOT(result.success) THEN
	moduleBuffer^.SYS_noFile();
END_IF
//Sub id is set, it will be overwritten if found in file
moduleBuffer^._SID								:=		subID;
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
	registerAutoLoadedModule.success			:=		FALSE;
	registerAutoLoadedModule.code				:=		ERCodes.FB_ModuleManager_registerAutoLoadedModule;
	FU_SafeDelete(pMem:=moduleBuffer);
	RETURN;
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
registerAutoLoadedModule							:=		moduleBuffer^.SYS_constructor(boot:=NOT(S_loadDone));
IF NOT(registerAutoLoadedModule.success) THEN
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