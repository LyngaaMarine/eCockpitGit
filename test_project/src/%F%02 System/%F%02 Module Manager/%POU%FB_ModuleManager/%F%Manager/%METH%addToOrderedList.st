//This method adds the module the the ordered list of modules
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-02-22 | Creation
METHOD PROTECTED addToOrderedList
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR

(*%!%__DELIMITER__%!%*)
S_modulesInOrder[S_modulesAmount + 1]	:=		module;
S_modulesAmount						:=		S_modulesAmount + 1;