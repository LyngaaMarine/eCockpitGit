//This function creates a user in the operating system
//Returns true if successfull
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-11-20 | Creation
FUNCTION removeUser : BOOL
VAR_INPUT
	user		:STRING(40);	//Name of user
END_VAR
(*%!%__DELIMITER__%!%*)
FU_checkDirExists		:=		executeShellCommand(command:=FU_sConcat3(s1:='deluser ',s2:=user,s3:='')) = 'a';