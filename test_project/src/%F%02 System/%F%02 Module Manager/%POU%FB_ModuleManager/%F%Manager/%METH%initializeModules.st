//This method initializes the module manager
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-19 | Creation
METHOD initializeModules : SLMResult
VAR_INPUT
	pouSpeed				:WORD;
END_VAR
VAR
	i						:WORD;
	subIDBuffer				:AModuleSID;
	desBuffer				:AModuleDes;
	subOffset				:AModuleSID;
	invalidOffset			:AModuleSID;
	moduleBuffer			:POINTER TO FB_Module;
	pathBuffer				:APath;
	dirBuffer				:SysTypes.RTS_IEC_HANDLE;
	result					:RTS_IEC_RESULT;
	foundDirInfoBuffer		:SysDir.DirInfo;
	foundColonPosition		:WORD;
	foundSubID				:WORD;
	foundDirEntry			:APath;
	generatedModule			:POINTER TO FB_Module;
	resultBuffer			:SLMResult;
END_VAR
(*%!%__DELIMITER__%!%*)
CASE S_moduleInitialization OF
	0:	//Auto load of sub modules
		FOR S_moduleInitProgress := S_moduleInitProgress TO S_modulesAmount DO
			//Module is gotten
			moduleBuffer					:=		S_modulesInOrder[S_moduleInitProgress];
			//This saves the last module so if init fails, it is possible to tell which one failed
			S_failedModule					:=		moduleBuffer;
			S_failedModuleType				:=		moduleBuffer^.SYS_designator;
			
			//Module add subs is run
			S_failedResult					:=		moduleBuffer^.SYS_addSubModules(boot:=TRUE);
			IF NOT(S_failedResult.success) THEN
				initializeModules			:=		S_failedResult;	
				RETURN;
			END_IF

			//Auto loading of sub modules
			IF moduleBuffer^.SYS_canAutoLoad THEN
				pathBuffer					:=		getPath(module:=moduleBuffer,dirPath:=TRUE);
				//Directory is opened
				dirBuffer					:=		SysDir.SysDirOpen(szDir:=pathBuffer,szDirEntry:=foundDirEntry,diMaxDirEntry:=SIZEOF(foundDirEntry),pDirInfo:=ADR(foundDirInfoBuffer) ,pResult:=ADR(result));
				//If directory exists
				IF dirBuffer <> 0 AND TO_DWORD(dirBuffer) <> 4294967295 THEN
					//Every file in the directory is loaded
					WHILE TRUE DO
						//File is gotten
						result				:=		SysDir.SysDirRead(hDir:=dirBuffer,szDirEntry:=foundDirEntry,diMaxDirEntry:=SIZEOF(foundDirEntry),pDirInfo:=ADR(foundDirInfoBuffer));
						//Check that file was found
						IF result <> 0 THEN
							EXIT;
						END_IF
						//This only loads files not directories
						IF foundDirInfoBuffer.diDirectory.1 = FALSE THEN
							foundColonPosition		:=		FU_wFind(s1:=foundDirEntry,s2:=GUTF8.SemiColon);
							IF foundColonPosition <> 0 THEN
								//This makes sure that only files with a valid number sub id gets auto loaded
								subIDBuffer			:=		extractValidSubID(path:=foundDirEntry);
								IF subIDBuffer <> 0 THEN
									resultBuffer	:=		moduleBuffer^.SYS_generateSubModule(
																des:=FU_sMid(sStr:=foundDirEntry,wLen:=FU_wFind(s1:=foundDirEntry,s2:=GUTF8.Dot) - foundColonPosition - 1,wPos:=foundColonPosition + 1),
																module=>generatedModule
															);
									IF resultBuffer.success THEN
										registerAutoLoadedModule(moduleBuffer:=generatedModule,parentModule:=moduleBuffer,subID:=subIDBuffer);
									END_IF									
								END_IF
							END_IF
						END_IF
					END_WHILE
				END_IF
			END_IF
			
			//Makes sure all sub ids are in order
			IF S_subModulesBufferAmount > 0 OR S_subModulesInvalidAmount > 0 THEN
				subOffset											:=		0;
				invalidOffset										:=		1;
				FOR i := 1 TO S_subModulesBufferAmount + S_subModulesInvalidAmount DO
					IF S_subModulesBuffer[i + subOffset] <> 0 THEN
						registerChildWithModule(parentModule:=moduleBuffer,childModule:=S_subModulesBuffer[i + subOffset],deOrRegister:=FALSE);
						IF subOffset > 0 THEN
							moveModuleFile(moduleToMove:=S_subModulesBuffer[i + subOffset],newParentModule:=moduleBuffer,newSID:=i);
						END_IF
						S_subModulesBuffer[i + subOffset]			:=		0;
					ELSIF S_subModulesInvalidAmount > 0 THEN
						registerChildWithModule(parentModule:=moduleBuffer,childModule:=S_subModulesInvalidBuffer[invalidOffset],deOrRegister:=FALSE);
						moveModuleFile(moduleToMove:=S_subModulesInvalidBuffer[invalidOffset],newParentModule:=moduleBuffer,newSID:=i);
						S_subModulesInvalidBuffer[invalidOffset]	:=		0;
						invalidOffset		:=		invalidOffset + 1;
					ELSE
						subOffset			:=		subOffset + 1;
						i					:=		i - 1;
					END_IF
				END_FOR
			END_IF
			S_subModulesBufferAmount		:=		0;
			S_subModulesInvalidAmount		:=		0;
			
			
		END_FOR
		S_moduleInitialization				:=		S_moduleInitialization + 1;
		S_moduleInitProgress				:=		1;
	1:	//Gives all modules missing UID an uid
		IF S_missingUID <> 0 THEN
			FOR S_moduleInitProgress := S_moduleInitProgress TO S_modulesAmount DO
				moduleBuffer				:=		S_modulesInOrder[S_moduleInitProgress];
				IF moduleBuffer^._UID = 0 THEN
					moduleBuffer^._UID		:=		getNextFreeUID();
					S_missingUID			:=		S_missingUID - 1;		
					IF moduleBuffer^._UID = 0 THEN
						removeFromOrderedList(module:=moduleBuffer);
						FU_SafeDelete(pMem:=moduleBuffer);
					ELSE
						registerModuleByUID(module:=moduleBuffer);
						saveModule(module:=moduleBuffer,dontLog:=TRUE);
					END_IF
				END_IF
			END_FOR
		END_IF
		S_moduleInitialization				:=		S_moduleInitialization + 1;
		S_moduleInitProgress				:=		1;
		S_loadDone							:=		TRUE;
	2:	//Initialization of all Modules
		FOR S_moduleInitProgress := S_moduleInitProgress TO S_modulesAmount DO
			moduleBuffer					:=		S_modulesInOrder[S_moduleInitProgress];
			S_failedModule					:=		moduleBuffer;
			S_failedModuleType				:=		moduleBuffer^.SYS_designator;
			S_failedResult					:=		moduleBuffer^.SYS_init(pouSpeed:=pouSpeed);
			IF S_failedResult.success THEN
				IF S_failedResult.code = ERCodes.MoreTime THEN
					initializeModules.code	:=		ERCodes.MoreTime;
					RETURN;	
				END_IF
			ELSE
				initializeModules			:=		S_failedResult;
			END_IF
		END_FOR
		S_moduleInitialization				:=		S_moduleInitialization + 1;
		S_moduleInitProgress				:=		1;
	3:	//First run of modules
		FOR S_moduleInitProgress := S_moduleInitProgress TO S_modulesAmount DO
			moduleBuffer					:=		S_modulesInOrder[S_moduleInitProgress];
			S_failedModule					:=		moduleBuffer;
			S_failedModuleType				:=		moduleBuffer^.SYS_designator;
			moduleBuffer^.SYS_firstRun();
		END_FOR
		S_currentTimeDWORD					:=		SysTimeRtc.SysTimeRtcGet(pResult:=result);	//System time in seconds is calculated
		S_currentTimeDT						:=		TO_DT(S_currentTimeDWORD);			//The system time is read from the RTC
		S_currentTimeInt					:=		TO_STRING(S_currentTimeDT);			//The system time is read from the RTC
		S_bootTime							:=		S_currentTimeDWORD;
		///Logs.logEvent(module:=THIS,logString:='System initialisation completed');
		S_initialized						:=		TRUE;
		RETURN;
END_CASE
initializeModules.code						:=		ERCodes.MoreTime;
