{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method outputs the start address and size of the currently selected object
//True when ok
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD exportSelection : BOOL
VAR_OUTPUT
	position		:POINTER TO EASCII;
	size			:DWORD;
END_VAR
VAR
	inString		:BOOL;
	posBuffer		:POINTER TO EASCII := treeSelected[treeLevel];
	level			:WORD;		//This value makes sure it doesn't return a key from inside another object
END_VAR
!__IMPLEMENTATION__!
IF ready AND treeLevel > 0 THEN
	position			:=		treeSelected[treeLevel];
	WHILE posBuffer < bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:EXIT;
			EASCII.DoubleQoute: IF checkNoBackSlash(checkPos:=posBuffer) THEN inString := NOT(inString); END_IF
			EASCII.CloseBraces,EASCII.SqBracketC: IF NOT(inString) THEN IF level > 1 THEN level := level - 1;ELSE EXIT; END_IF END_IF
			EASCII.OpenBraces,EASCII.SqBracketO: IF NOT(inString) THEN level := level + 1; END_IF
		END_CASE	
		posBuffer												:=		posBuffer + 1;
	END_WHILE
	size				:=		posBuffer - position + 1;
	exportSelection		:=		TRUE;
END_IF