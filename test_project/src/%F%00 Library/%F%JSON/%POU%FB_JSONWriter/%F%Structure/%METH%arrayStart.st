//This starts a new array
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD arrayStart : BOOL
VAR_INPUT
	singleLine		:BOOL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF ready AND (afterKey OR inArray) AND treeLevel < levelsMax THEN
	//Struct tag starts
	addChar(char:=EASCII.SqBracketO);
	treeLevel					:=		treeLevel + 1;
	treeTypes[treeLevel]		:=		EStructType.tArray;
	treeSingleLine[treeLevel]	:=		singleLine;
	//New Line
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	inArray						:=		TRUE;
	afterKey					:=		FALSE;
	inObject					:=		FALSE;
	arrayStart					:=		TRUE;
	emptyBlock					:=		TRUE;
END_IF