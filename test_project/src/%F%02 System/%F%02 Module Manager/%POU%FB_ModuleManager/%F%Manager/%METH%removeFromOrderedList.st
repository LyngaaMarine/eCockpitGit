//This method adds the module the the ordered list of modules
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-02-22 | Creation
METHOD PROTECTED removeFromOrderedList
VAR_INPUT
	module			:POINTER TO FB_Module;	
END_VAR
VAR
	i				:AModuleUID;
	found			:BOOL;
END_VAR
(*%!%__DELIMITER__%!%*)
S_modulesAmount										:=		S_modulesAmount - 1;
IF S_modulesAmount > 0 THEN
	FOR i := 1 TO S_modulesAmount DO
		IF found THEN
			IF S_modulesInOrder[i] <> 0 THEN
				S_modulesInOrder[i]					:=		S_modulesInOrder[i + 1];
			ELSE
				RETURN;
			END_IF
		ELSE
			IF S_modulesInOrder[i] = module THEN
				found								:=		TRUE;
				S_modulesInOrder[i]					:=		S_modulesInOrder[i + 1];
			END_IF
		END_IF
	END_FOR
END_IF