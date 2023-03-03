//This function gets deletes a file by the path
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-04-19 | Creation
FUNCTION FU_renameDirByName : SLMResult
VAR_INPUT
	sDirPath		:APath;	//Path of directory to rename
	sDirPathNewName	:APath;	//New path/name for the directory
END_VAR
VAR
	code			:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
//Path cannot be empty
IF sDirPath <> '' THEN
	//System function is called and return is converted
	CASE SysDir.SysDirRename(szOldDirName:=sDirPath,szNewDirName:=sDirPathNewName) OF
		0:;
		2:
			FU_renameDirByName.success	:=		FALSE;
			FU_renameDirByName.code		:=		ERCodes.FU_renameDirByName;
			FU_renameDirByName.reason	:=		GTErrors.EpathIsFile;
		16:
			FU_renameDirByName.success	:=		FALSE;
			FU_renameDirByName.code		:=		ERCodes.FU_renameDirByName;
			FU_renameDirByName.reason	:=		GTErrors.EdirectoryDoesntExist;
	ELSE
		FU_renameDirByName.success		:=		FALSE;
		FU_renameDirByName.code			:=		ERCodes.FU_renameDirByName;
		FU_renameDirByName.reason		:=		GTErrors.EgeneralFailure;
	END_CASE
ELSE
	FU_renameDirByName.success			:=		FALSE;
	FU_renameDirByName.code				:=		ERCodes.FU_renameDirByName;
	FU_renameDirByName.reason			:=		GTErrors.EpathMissing;
END_IF