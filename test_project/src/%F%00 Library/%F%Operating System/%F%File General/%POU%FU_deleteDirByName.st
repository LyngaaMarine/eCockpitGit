{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function gets deletes a file by the path
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-04-19 | Creation
FUNCTION FU_deleteDirByName : SLMResult
VAR_INPUT
	sDirPath		:APath;	//Path of directory to delete
	xOnlyContent	:BOOL;	//When true only the content of the dir is deleted
END_VAR
!__IMPLEMENTATION__!
//Path cannot be empty
IF sDirPath <> '' THEN
	//System function is called and return is converted
	CASE SysDir.SysDirDelete2(szDir:=sDirPath,xRecursive:=TRUE,xKeepDir:=xOnlyContent) OF
		0:;
		2:
			FU_deleteDirByName.success		:=		FALSE;
			FU_deleteDirByName.code			:=		ERCodes.FU_deleteDirByName;
			FU_deleteDirByName.reason		:=		GTErrors.EpathIsFile;
		16:
			FU_deleteDirByName.success		:=		FALSE;
			FU_deleteDirByName.code			:=		ERCodes.FU_deleteDirByName;
			FU_deleteDirByName.reason		:=		GTErrors.EdirectoryDoesntExist;
	ELSE
		FU_deleteDirByName.success			:=		FALSE;
		FU_deleteDirByName.code				:=		ERCodes.FU_deleteDirByName;
		FU_deleteDirByName.reason			:=		GTErrors.EgeneralFailure;
	END_CASE
ELSE
	FU_deleteDirByName.success				:=		FALSE;
	FU_deleteDirByName.code					:=		ERCodes.FU_deleteDirByName;
	FU_deleteDirByName.reason				:=		GTErrors.EpathMissing;
END_IF