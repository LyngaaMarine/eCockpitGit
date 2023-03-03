//This function gets deletes a file by the path
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-04-19 | Creation
// | Result Codes         |
// | OK                   | The file was deleted
// | PathEmpty            | The inputted path is empty
// | FileDontExist        | The file doesn't exist
// | PathIsDir            | The inputted path is a directory
// | GeneralFailure       | Undescribed Failure
FUNCTION FU_deleteFileByName : SLMResult
VAR_INPUT
	sFilePath		:APath;	//Path of file to delete
END_VAR
(*%!%__DELIMITER__%!%*)
//Path cannot be empty
IF sFilePath <> '' THEN
	//System function is called and return is converted
	CASE SysFile.SysFileDelete(szFileName:= sFilePath) OF
		0:;
		2:
			FU_deleteFileByName.success		:=		FALSE;
			FU_deleteFileByName.code		:=		ERCodes.FU_deleteFileByName;
			FU_deleteFileByName.reason		:=		GTErrors.EpathIsDir;
		16:
			FU_deleteFileByName.success		:=		FALSE;
			FU_deleteFileByName.code		:=		ERCodes.FU_deleteFileByName;
			FU_deleteFileByName.reason		:=		GTErrors.EfileDoesntExist;
	ELSE
		FU_deleteFileByName.success			:=		FALSE;
		FU_deleteFileByName.code			:=		ERCodes.FU_deleteFileByName;
		FU_deleteFileByName.reason			:=		GTErrors.EgeneralFailure;
	END_CASE
ELSE
	FU_deleteFileByName.success				:=		FALSE;
	FU_deleteFileByName.code				:=		ERCodes.FU_deleteFileByName;
	FU_deleteFileByName.reason				:=		GTErrors.EpathMissing;
END_IF