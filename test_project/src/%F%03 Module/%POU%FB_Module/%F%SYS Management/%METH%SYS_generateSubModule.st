//Generates a sub module for the given module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 17-02-22 | Creation
METHOD SYS_generateSubModule : SLMResult
VAR_INPUT
	des				:AModuleDes;	//Designator of sub module
END_VAR
VAR_OUTPUT
	module			:POINTER TO FB_Module;
END_VAR
(*%!%__DELIMITER__%!%*)
