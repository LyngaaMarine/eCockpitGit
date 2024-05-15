{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeString
VAR_INPUT
	value			:POINTER TO EASCII;	//Address of string for the filler text
END_VAR
!__IMPLEMENTATION__!
IF ready AND (afterKey OR_ELSE inArray OR_ELSE singleVal) THEN
	addChar(char:=EASCII.DoubleQoute);
	AddString(pString:=value);
	addChar(char:=EASCII.DoubleQoute);
	lastComma		:=		bufferPosition;
	addChar(char:=EASCII.Comma);
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	afterKey		:=		FALSE;
	singleVal		:=		FALSE;
	emptyBlock		:=		FALSE;
END_IF
