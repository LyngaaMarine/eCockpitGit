{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function checks if a dir exists
//Returns true if dir exists
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-12-19 | Creation
// | 2         | NSN      | 22-11-20 | Removed dependency on wago lib and based on shell comman
FUNCTION FU_checkDirExists : BOOL
VAR_INPUT
	path		:APath;	//Path of directory to copy from
END_VAR
!__IMPLEMENTATION__!
FU_checkDirExists		:=		executeShellCommand(command:=FU_sConcat3(s1:='if test -d "',s2:=path,s3:='"; then printf "a"; fi')) = 'a';