{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function copies a directory
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-04-19 | Creation
FUNCTION FU_copyFileByName : SLMResult
VAR_INPUT
	sFilePathSrc		:APath;	//Path of directory to copy from
	sFilePathDes		:APath;	//Path of directory to copy to
END_VAR
VAR_OUTPUT
	amountByteCopied	:__XWORD;
END_VAR
VAR
	resultcode			:RTS_IEC_RESULT;
END_VAR
!__IMPLEMENTATION__!
//Paths cannot be empty
IF sFilePathSrc <> '' AND sFilePathDes <> '' THEN
	//File is created to ensure path is valid
	SysFile.SysFileClose(hFile:=SysFile.SysFileOpen(szFile:=sFilePathDes,am:=SysFile.ACCESS_MODE.AM_APPEND_PLUS,pResult:=ADR(resultcode)));
	//System copy function is called, and return is converted
	CASE SysFile.SysFileCopy(szSourceFileName:=sFilePathSrc,szDestFileName:=sFilePathDes,pulCopied:=ADR(amountByteCopied)) OF
		0:	;
		16:
			FU_copyFileByName.success		:=		FALSE;
			FU_copyFileByName.code			:=		ERCodes.FU_copyFileByName;
			FU_copyFileByName.reason		:=		GTErrors.EsourceFileDontExist;
	END_CASE
ELSE
	FU_copyFileByName.success				:=		FALSE;
	FU_copyFileByName.code					:=		ERCodes.FU_copyFileByName;
	FU_copyFileByName.reason				:=		GTErrors.EpathMissing;
END_IF