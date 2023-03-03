//Method for getting the name of a module with placeholders filled
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 14-12-20 | Creation
METHOD getModuleUnit : AModuleUnit
VAR_INPUT
	module			:POINTER TO FB_Module;
	layer			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
IF module^._unit <> 0 THEN
	getModuleUnit						:=		module^._unit^;
END_IF