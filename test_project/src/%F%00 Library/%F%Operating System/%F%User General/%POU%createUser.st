//This function creates a user in the operating system
//Returns true if successfull
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-11-20 | Creation
FUNCTION createUser : BOOL
VAR_INPUT
	user		:STRING(40);	//Name of user
	passwd		:STRING(40);	//Name of user
END_VAR
(*%!%__DELIMITER__%!%*)
createUser		:=		executeShellCommand(command:=FU_sConcat7(s1:='printf "',s2:=passwd,s3:='\n',s4:=passwd,s5:='" | adduser ',s6:=user,s7:='')) = 'a';