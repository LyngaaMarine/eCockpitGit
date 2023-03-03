{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function gets deletes a file by the path
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-04-19 | Creation
FUNCTION FU_renameFileByName : SLMResult
VAR_INPUT
	sFilePath		:APath;	//Path of file to delete
	sFilePathNewName:APath;	//New path/name for the file
END_VAR
VAR
	code			:dWORD;
END_VAR
!__IMPLEMENTATION__!
//Path cannot be empty
IF sFilePath <> '' THEN
	//System function is called and return is converted
	CASE SysFile.SysFileRename(szOldFileName:=sFilePath,szNewFileName:=sFilePathNewName) OF
		0:;
		2:
			FU_renameFileByName.success		:=		FALSE;
			FU_renameFileByName.code		:=		ERCodes.FU_renameFileByName;
			FU_renameFileByName.reason		:=		GTErrors.EpathIsDir;
		16:
			FU_renameFileByName.success		:=		FALSE;
			FU_renameFileByName.code		:=		ERCodes.FU_renameFileByName;
			FU_renameFileByName.reason		:=		GTErrors.EfileDoesntExist;
	ELSE
		FU_renameFileByName.success			:=		FALSE;
		FU_renameFileByName.code			:=		ERCodes.FU_renameFileByName;
		FU_renameFileByName.reason			:=		GTErrors.EpathMissing;
	END_CASE
ELSE
	FU_renameFileByName.success				:=		FALSE;
	FU_renameFileByName.code				:=		ERCodes.FU_renameFileByName;
	FU_renameFileByName.reason				:=		GTErrors.EpathMissing;
END_IF