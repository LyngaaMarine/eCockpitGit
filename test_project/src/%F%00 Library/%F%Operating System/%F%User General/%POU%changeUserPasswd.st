{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function creates a user in the operating system
//Returns true if successfull
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-11-20 | Creation
FUNCTION changeUserPasswd : BOOL
VAR_INPUT
	user		:STRING(40);	//Name of user
	passwd		:STRING(40);	//Name of user
END_VAR
!__IMPLEMENTATION__!
FU_checkDirExists		:=		executeShellCommand(command:=FU_sConcat7(s1:='printf "',s2:=passwd,s3:='\n',s4:=passwd,s5:='" | passwd ',s6:=user,s7:='')) = 'a';