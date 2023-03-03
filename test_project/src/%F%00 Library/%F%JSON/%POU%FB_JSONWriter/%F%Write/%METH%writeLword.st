//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 16-05-21 | Creation
METHOD writeLword
VAR_INPUT
	value			:LWORD;
END_VAR
VAR
	buffer			:STRING(20);
END_VAR
(*%!%__DELIMITER__%!%*)
IF ready AND (afterKey OR_ELSE inArray OR_ELSE singleVal) THEN
	buffer					:=		TO_STRING(value);
	addString(pString:=ADR(buffer));
	lastComma		:=		bufferPosition;
	addChar(char:=EASCII.Comma);
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	afterKey		:=		FALSE;
	singleVal		:=		FALSE;
	emptyBlock		:=		FALSE;
END_IF
