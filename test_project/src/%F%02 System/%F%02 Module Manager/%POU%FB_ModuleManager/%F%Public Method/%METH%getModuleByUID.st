//Method for getting an module by the id
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 27-07-19 | Creation
METHOD getModuleByUID : POINTER TO BYTE
VAR_INPUT
	modUID			:AModuleUID;			//The ID of the io to get
END_VAR
(*%!%__DELIMITER__%!%*)
IF modUID > S_highestUID OR ModUID = 0 THEN
	RETURN;
END_IF
getModuleByUID		:=		S_modules[modUID];