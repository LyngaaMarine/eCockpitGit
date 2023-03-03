//Method called before after module data is loaded
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-11-20 | Creation
METHOD SYS_constructor : SLMResult
VAR_INPUT
	boot		:BOOL;		//Is true when creation happens during boot
END_VAR
(*%!%__DELIMITER__%!%*)
;