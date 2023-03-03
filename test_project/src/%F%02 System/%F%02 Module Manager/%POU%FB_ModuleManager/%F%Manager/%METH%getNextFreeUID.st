{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method gets the next unique id
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-19 | Creation
METHOD PROTECTED getNextFreeUID : AModuleUID
VAR
	i		:AModuleUID;
END_VAR
!__IMPLEMENTATION__!
FOR i := 1 TO S_highestUID DO
	IF S_modules[i] = 0 THEN
		getNextFreeUID			:=		i;
		RETURN;
	END_IF
END_FOR
IF S_highestUID < GParameters.maxModules THEN
	getNextFreeUID				:=		S_highestUID + 1;
END_IF