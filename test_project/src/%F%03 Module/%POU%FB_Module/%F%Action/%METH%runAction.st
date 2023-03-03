//This method runs an action for the module with parameters
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-08-21 | Creation
//The run action method is an interface to call actions an as such should only contain lightweight loads
//If anything cpu intensive must be run, it must be run async
METHOD runAction : SLMResult
VAR_INPUT
	actionID		:WORD;		//Id for action, the same id can be used on different modules 40000-50000 are reserved for system
	actionParams	:POINTER TO AActionParams;	//Parameter data structure is defined in actionParamStruct
END_VAR

(*%!%__DELIMITER__%!%*)
CASE actionID OF
	0:	runAction.success		:=		TRUE;	
END_CASE