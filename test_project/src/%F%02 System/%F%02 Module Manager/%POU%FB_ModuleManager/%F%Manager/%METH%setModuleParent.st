{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for chaninge the parent of a module
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-02-22 | Creation
METHOD setModuleParent :SLMResult
VAR_INPUT
	module			:POINTER TO FB_Module;
	newParent		:POINTER TO FB_Module;
END_VAR

!__IMPLEMENTATION__!
IF module^._parent <> 0 THEN
	registerChildWithModule(parentModule:=module,childModule:=module,deOrRegister:=TRUE);
END_IF
IF newParent <> 0 THEN
	setModuleParent			:=		registerChildWithModule(parentModule:=newParent,childModule:=module,deOrRegister:=FALSE);
	module^._parent			:=		newParent;
ELSE
	module^._parent			:=		0;
END_IF