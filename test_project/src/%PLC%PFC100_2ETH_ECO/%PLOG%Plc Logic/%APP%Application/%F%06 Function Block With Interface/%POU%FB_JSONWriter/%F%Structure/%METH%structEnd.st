{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This ends the previously started object
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD structEnd : BOOL
VAR
	moveCommaBuffer		:POINTER TO EASCII;
END_VAR
!__IMPLEMENTATION__!
IF ready AND treeLevel > 0 AND treeTypes[treeLevel] = EStructType.object OR treeTypes[treeLevel] = EStructType.tArray THEN
	IF afterKey THEN
		writeNull();
	END_IF
	IF NOT(emptyBlock) THEN
		IF lastComma <> 0 THEN
			WHILE lastComma < bufferPosition DO
				moveCommaBuffer		:=		lastComma + 1;
				lastComma^			:=		moveCommaBuffer^;
				lastComma			:=		lastComma + 1;
			END_WHILE
			bufferPosition			:=		bufferPosition - 1;
			lastComma				:=		0;
		END_IF
	END_IF
	//Last TAB is deleted
	IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
		bufferPosition			:=		bufferPosition - 1;
	END_IF
	//struct tag ends
	CASE treeTypes[treeLevel] OF
		EStructType.tArray:
			addChar(char:=EASCII.SqBracketC);
		EStructType.object:
			addChar(char:=EASCII.CloseBraces);
	END_CASE
	lastComma					:=		bufferPosition;
	addChar(char:=EASCII.Comma);
	treeLevel					:=		treeLevel - 1;
	IF treeLevel > 0 THEN 
		IF NOT(useSingleLine) AND NOT(treeSingleLine[treeLevel]) THEN
			addNewLine();
		END_IF
		CASE treeTypes[treeLevel] OF
			EStructType.tArray:
				inArray			:=		TRUE;
				inObject		:=		FALSE;
			EStructType.object:
				inObject		:=		TRUE;
				inArray			:=		FALSE;
		END_CASE
	END_IF
	structEnd					:=		TRUE;			
	emptyBlock					:=		FALSE;
END_IF