{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function copies a directory
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-04-19 | Creation
FUNCTION FU_copyDirByName : SLMResult
VAR_INPUT
	sDirPathSrc		:APath;	//Path of directory to copy from
	sDirPathDes		:APath;	//Path of directory to copy to
	xRecursive		:BOOL;	//Whether to copy all files contained
	xOverwrite		:BOOL;	//Whether to overwrite files on destination path
END_VAR
!__IMPLEMENTATION__!
//Paths cannot be empty
IF sDirPathSrc <> '' AND sDirPathDes <> '' THEN
	//System copy function is called, and return is converted
	CASE SysDir.SysDirCopy(szSourceDir:=sDirPathSrc,szDestDir:=sDirPathDes,xRecursive:=xRecursive,xOverwrite:=xOverwrite) OF
		0:;
		16:
			FU_copyDirByName.success	:=		FALSE;
			FU_copyDirByName.code		:=		ERCodes.FU_copyDirByName;
			FU_copyDirByName.reason		:=		GTErrors.EsourceDirDontExist;
	END_CASE
ELSE
	FU_copyDirByName.success			:=		FALSE;
	FU_copyDirByName.code				:=		ERCodes.FU_copyDirByName;
	FU_copyDirByName.reason				:=		GTErrors.EpathMissing;
END_IF