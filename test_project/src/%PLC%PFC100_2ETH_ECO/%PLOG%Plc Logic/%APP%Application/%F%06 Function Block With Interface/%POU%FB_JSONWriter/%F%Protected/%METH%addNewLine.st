{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This adds a new line and the appropriate amount of tabs
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD PROTECTED addNewLine
VAR
	i				:WORD;
END_VAR
!__IMPLEMENTATION__!
IF ready THEN
	//New Line
	addChar(char := EASCII.LF);
	//Tabs are added
	IF treeLevel > 0 THEN
		FOR i := treeLevel TO 1 BY -1 DO
			addChar(char := EASCII.Tab);
		END_FOR
	END_IF
END_IF
