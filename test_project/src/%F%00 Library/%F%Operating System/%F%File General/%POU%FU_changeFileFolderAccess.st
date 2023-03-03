//This function changes the access of a file
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 14-10-21 | Creation
FUNCTION FU_changeFileFolderAccess : SLMResult
VAR_INPUT
	path			:APath;
	ownerRead		:BOOL;
	ownerWrite		:BOOL;
	ownerExecute	:BOOL;
	groupRead		:BOOL;
	groupWrite		:BOOL;
	groupExecute	:BOOL;
	publicRead		:BOOL;
	publicWrite		:BOOL;
	publicExecute	:BOOL;
END_VAR
VAR
	ownerByte		:BYTE;
	groupByte		:BYTE;
	publicByte		:BYTE;
	access			:STRING(3);
	pathInt			:STRING(SIZEOF(APath) + 20);
END_VAR
(*%!%__DELIMITER__%!%*)
ownerByte.0			:=		ownerExecute;
ownerByte.1			:=		ownerWrite;
ownerByte.2			:=		ownerRead;
access[0]			:=		ownerByte + 48;

groupByte.0			:=		groupExecute;
groupByte.1			:=		groupWrite;
groupByte.2			:=		groupRead;
access[1]			:=		groupByte + 48;

publicByte.0		:=		publicExecute;
publicByte.1		:=		publicWrite;
publicByte.2		:=		publicRead;
access[2]			:=		publicByte + 48;
access[3]			:=		0;

IF executeShellCommand(command:=FU_sConcat5BI(s1:=ADR('chmod '),s2:=ADR(access),s3:=ADR(' '),s4:=ADR(path),s5:=ADR(' || printf "a"'))) = 'a' THEN
	FU_changeFileFolderAccess.success		:=		FALSE;
	FU_changeFileFolderAccess.code			:=		ERCodes.changeFileFolderAccess;
	FU_changeFileFolderAccess.reason		:=		GTErrors.EfileDoesntExist;
END_IF