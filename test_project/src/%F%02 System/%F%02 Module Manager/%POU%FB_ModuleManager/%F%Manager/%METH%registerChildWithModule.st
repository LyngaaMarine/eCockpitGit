{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for registering a child with the module
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 10-02-22 | Creation
METHOD registerChildWithModule : SLMResult
VAR_INPUT
	parentModule	:POINTER TO FB_Module;
	childModule		:POINTER TO FB_Module;
	deOrRegister	:BOOL;					//Register or deregister child, true=remove, false=add
END_VAR
VAR
	i				:WORD;
END_VAR

!__IMPLEMENTATION__!
IF deOrRegister THEN
	FU_DynPointArrayOrderRemove(workingArray:=parentModule^._children,arrayAmount:=parentModule^._amountChildren,removePoint:=childModule);
	IF childModule^._SID <= parentModule^._amountChildren THEN
		FOR i := childModule^._SID TO parentModule^._amountChildren DO
			moveModuleFile(moduleToMove:=parentModule^._children^[i - 1],newParentModule:=parentModule,newSID:=i);
		END_FOR
	END_IF
	childModule^._SID							:=		0;
	IF parentModule^._amountChildren = 0 THEN
		FU_deleteDirByName(sDirPath:=getPath(module:=parentModule,dirPath:=TRUE),xOnlyContent:=FALSE);
	END_IF
ELSE
	registerChildWithModule						:=		FU_DynPointArrayOrderAdd(workingArray:=parentModule^._children,arrayAmount:=parentModule^._amountChildren,addPoint:=childModule,incrementAmount:=16);	
END_IF