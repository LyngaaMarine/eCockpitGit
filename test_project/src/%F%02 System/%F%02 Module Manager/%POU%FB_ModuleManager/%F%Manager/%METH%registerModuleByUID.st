{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method sets the module in the array by its uid
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-02-22 | Creation
METHOD PROTECTED registerModuleByUID : SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR

!__IMPLEMENTATION__!
IF module^._UID > 0 AND module^._UID <= GParameters.maxModules THEN
	IF S_modules[module^._UID] = 0 THEN
		S_modules[module^._UID]			:=		module;
		IF module^._UID > S_highestUID THEN
			S_highestUID					:=		module^._UID;
		END_IF
	ELSE
		registerModuleByUID.success		:=		FALSE;
		registerModuleByUID.code		:=		ERCodes.ModuleManager_setModuleByUID;
		registerModuleByUID.reason		:=		ADR('UID already taken');	
	END_IF
ELSE
	registerModuleByUID.success			:=		FALSE;
	registerModuleByUID.code			:=		ERCodes.ModuleManager_setModuleByUID;
	registerModuleByUID.reason			:=		ADR('UID out of range');	
END_IF