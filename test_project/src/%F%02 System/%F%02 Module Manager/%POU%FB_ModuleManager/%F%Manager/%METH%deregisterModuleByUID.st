//This method unregisters the module from the module array by its uid
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-02-22 | Creation
METHOD PROTECTED deregisterModuleByUID
VAR_INPUT
	module			:POINTER TO FB_Module;
END_VAR
VAR
	i				:AModuleUID;
END_VAR
(*%!%__DELIMITER__%!%*)
S_modules[module^._UID]			:=		0;
IF module^._UID = S_highestUID THEN
	FOR i := S_highestUID - 1 TO 1 BY - 1 DO
		IF S_modules[i] <> 0 THEN
			S_highestUID			:=		i;
			RETURN;
		END_IF
	END_FOR
END_IF