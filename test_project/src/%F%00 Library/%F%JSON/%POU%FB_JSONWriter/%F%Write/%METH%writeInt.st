//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeInt
VAR_INPUT
	value			:INT;
END_VAR
VAR
	buffer			:STRING(6);
END_VAR
(*%!%__DELIMITER__%!%*)
IF ready AND (afterKey OR_ELSE inArray OR_ELSE singleVal) THEN
	buffer					:=		TO_STRING(value);
	addStringRaw(pString:=ADR(buffer));
	lastComma		:=		bufferPosition;
	addChar(char:=EASCII.Comma);
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	afterKey		:=		FALSE;
	singleVal		:=		FALSE;
	emptyBlock		:=		FALSE;
END_IF