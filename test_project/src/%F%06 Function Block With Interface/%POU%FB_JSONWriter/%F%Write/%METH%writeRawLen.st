{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method writes a string of a fixed size to the buffer as raw data without qoutes and escape characters
//Should only be used for copying data
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 13-10-21 | Creation
METHOD writeRawLen
VAR_INPUT
	value			:POINTER TO EASCII;	//Address of string for the filler text
	len				:DWORD;				//Amount of bytes to write
END_VAR
!__IMPLEMENTATION__!
IF ready AND (afterKey OR_ELSE inArray OR_ELSE singleVal) THEN
	addStringRawLen(pString:=value,len:=len);
	lastComma		:=		bufferPosition;
	addChar(char:=EASCII.Comma);
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	afterKey		:=		FALSE;
	singleVal		:=		FALSE;
	emptyBlock		:=		FALSE;
END_IF
