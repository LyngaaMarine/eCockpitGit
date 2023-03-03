{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function checks if a user exists in the operating system
//Returns true if user exists
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-11-20 | Creation
FUNCTION checkUserExists : BOOL
VAR_INPUT
	user		:APath;	//Name of user
END_VAR
!__IMPLEMENTATION__!
checkUserExists		:=		executeShellCommand(command:=FU_sConcat3(s1:='if id "',s2:=user,s3:='" &>/dev/null; then printf "a"; fi')) = 'a';