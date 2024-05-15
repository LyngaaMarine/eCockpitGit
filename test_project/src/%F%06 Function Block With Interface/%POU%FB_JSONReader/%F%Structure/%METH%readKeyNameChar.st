{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method returns the character of a given position from the key name
//Returns null if out of range
//Does not account for escape characters
//1 is the first character, 0 is also the first character
METHOD readKeyNameChar : EASCII
VAR_INPUT
	charNum			:WORD;		//Character number
END_VAR
VAR
	posBuffer		:POINTER TO EASCII;		//Buffer for key position
END_VAR
!__IMPLEMENTATION__!
IF ready AND lastValueType <> EStructType.none AND treeLevel > 0 AND charNum <= lastKeySize THEN
	IF charNum = 0 THEN
		posBuffer		:=		lastKeyStart + 1 + charNum;
	ELSE
		posBuffer		:=		lastKeyStart + charNum;
	END_IF
	readKeyNameChar		:=		posBuffer^;
END_IF