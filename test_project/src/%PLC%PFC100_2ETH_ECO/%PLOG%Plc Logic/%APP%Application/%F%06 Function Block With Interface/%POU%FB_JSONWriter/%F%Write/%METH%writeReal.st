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
METHOD writeReal
VAR_INPUT
	value			:REAL;
END_VAR
VAR
	buffer			:STRING(30);
	valuePoint		:POINTER TO DWORD := ADR(value);
END_VAR
!__IMPLEMENTATION__!
IF ready AND (afterKey OR_ELSE inArray OR_ELSE singleVal) THEN
	CASE valuePoint^ OF
		2139095040:	//Positive Infinity
			addChar(char:=EASCII.DoubleQoute);
			AddString(pString:=GTBigs.BInf);
			addChar(char:=EASCII.DoubleQoute);		
		4286578688:	//Negative Infinity
			addChar(char:=EASCII.DoubleQoute);
			AddString(pString:=GTBigs.BminusInf);
			addChar(char:=EASCII.DoubleQoute);		
		2143289344..2147483647,4290772992..4294967295:	//Not a Number
			addChar(char:=EASCII.DoubleQoute);
			AddString(pString:=GTBigs.BNaN);
			addChar(char:=EASCII.DoubleQoute);		
	ELSE
		buffer					:=		TO_STRING(value);
		addString(pString:=ADR(buffer));
	END_CASE
	lastComma		:=		bufferPosition;
	addChar(char:=EASCII.Comma);
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		addNewLine();
	END_IF
	afterKey		:=		FALSE;
	singleVal		:=		FALSE;
	emptyBlock		:=		FALSE;
END_IF