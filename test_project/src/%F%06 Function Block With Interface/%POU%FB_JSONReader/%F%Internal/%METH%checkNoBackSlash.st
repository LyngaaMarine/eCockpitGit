{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method checks if there is a backslash in front of the code, then checks if there is an backslash in front of that and so on, if the amount of backslashes is even or if there are none it returns true
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 06-07-20 | Creation
METHOD PROTECTED checkNoBackSlash : BOOL
VAR_INPUT
	checkPos		:POINTER TO EASCII;
END_VAR
VAR
	checkCount		:DWORD;
END_VAR
!__IMPLEMENTATION__!
IF checkPos > bufferADROrg THEN
	checkPos				:=		checkPos - 1;
	WHILE checkPos^ = EASCII.BackSlash AND_THEN checkPos > bufferADROrg DO
		checkCount			:=		checkCount + 1;
		checkPos			:=		checkPos - 1;
	END_WHILE
	checkNoBackSlash		:=		checkCount MOD 2 = 0;
ELSE
	checkNoBackSlash		:=		TRUE;	
END_IF