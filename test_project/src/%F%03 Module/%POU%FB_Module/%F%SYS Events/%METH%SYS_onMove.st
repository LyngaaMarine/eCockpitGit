//Method called when module is moved, if it fails the module is not moved
//The parent is already changed to the new parent
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-11-20 | Creation
METHOD SYS_onMove : SLMResult
VAR_INPUT
	oldParent		:POINTER TO FB_Module;		//Old parent of module
END_VAR

(*%!%__DELIMITER__%!%*)
;