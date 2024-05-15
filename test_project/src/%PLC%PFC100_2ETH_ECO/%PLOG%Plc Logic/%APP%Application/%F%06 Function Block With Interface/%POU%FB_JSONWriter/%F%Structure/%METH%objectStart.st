{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This starts a new object
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD objectStart : BOOL
VAR_INPUT
	singleLine		:BOOL;
END_VAR
!__IMPLEMENTATION__!
IF ready AND (afterKey OR inArray) AND treeLevel < levelsMax THEN
	//Struct tag starts
	addChar(char:=EASCII.OpenBraces);
	treeLevel					:=		treeLevel + 1;
	treeTypes[treeLevel]		:=		EStructType.object;
	treeSingleLine[treeLevel]	:=		singleLine;
	//New Line
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	afterKey					:=		FALSE;
	inArray						:=		FALSE;
	inObject					:=		TRUE;
	objectStart					:=		TRUE;
	emptyBlock					:=		TRUE;
END_IF