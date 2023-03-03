{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method moves the modules files and file struct from one place to another
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-02-22 | Creation
METHOD PROTECTED moveModuleFile : SLMResult
VAR_INPUT
	moduleToMove		:POINTER TO FB_Module;		//The module to move
	newParentModule		:POINTER TO FB_Module;		//The module to move the module into
	newSID				:AModuleSID;				//The new sub id to give the module
END_VAR
VAR
	oldPath				:APath;	
	oldDirPath			:APath;	

	i				:WORD;
	subID			:AModuleSID;
END_VAR
!__IMPLEMENTATION__!
IF moduleToMove = 0 OR newParentModule = 0 OR newSID = 0 OR newSID > GConstants.maxSubModules THEN
	moveModuleFile.success				:=		FALSE;
	moveModuleFile.code					:=		ERCodes.ModuleManager_moveModuleFile;
	RETURN;
END_IF

IF newParentModule = moduleToMove^._parent THEN
	//Dynamic modules
	IF moduleToMove^.SYS_saveName() = 'sub' THEN
		//If module has sub modules, the directory for it is renamed
		IF moduleToMove^._amountChildren > 0 THEN
			oldPath								:=		getPath(module:=moduleToMove,dirPath:=FALSE);
			oldDirPath							:=		getPath(module:=moduleToMove,dirPath:=TRUE);
			moduleToMove^._SID					:=		newSID;
			FU_renameFileByName(sFilePath:=oldPath,sFilePathNewName:=getPath(module:=moduleToMove,dirPath:=FALSE));
			FU_renameDirByName(sDirPath:=oldDirPath,sDirPathNewName:=getPath(module:=moduleToMove,dirPath:=TRUE));	
		ELSE
			oldPath								:=		getPath(module:=moduleToMove,dirPath:=FALSE);
			moduleToMove^._SID					:=		newSID;
			FU_renameFileByName(sFilePath:=oldPath,sFilePathNewName:=getPath(module:=moduleToMove,dirPath:=FALSE));
		END_IF
	//Modules with fixed name are just saved
	ELSE
		moduleToMove^._SID						:=		newSID;
	END_IF
	//This prevents the module from saving if uid has not yet been set during boot
	IF moduleToMove^._UID <> 0 THEN
		saveModule(module:=moduleToMove,dontLog:=TRUE);
	END_IF
ELSE
	;
END_IF