METHOD initializeManager : SLMResult
VAR
	result					:SysTypes.RTS_IEC_RESULT;
	cmdAmountFiles			:WORD;
	sysAmountFiles			:WORD;
	foundDirEntry			:APath;
	dirBuffer				:SysTypes.RTS_IEC_HANDLE;
	foundFileResult			:RTS_IEC_RESULT;
	foundDirInfoBuffer		:DirInfo;
	setUpReboot				:BOOL;
	resultBuffer			:SLMResult;
END_VAR
(*%!%__DELIMITER__%!%*)
S_currentTimeDWORD					:=		SysTimeRtc.SysTimeRtcGet(pResult:=result);	//System time in seconds is calculated
S_currentTimeDT						:=		TO_DT(S_currentTimeDWORD);			//The system time is read from the RTC
S_currentTimeInt					:=		TO_STRING(S_currentTimeDT);			//The system time is read from the RTC
S_bootTime							:=		S_currentTimeDWORD;
_UID								:=		1;
///Logs.logEvent(module:=THIS,logString:='System boot started');

//Check if file system is working correctly, to avoid bug where sometimes reading and writing from file doesn't work until system is restarted
///cmdAmountFiles						:=		TO_WORD(executeShellCommand(command:=FU_sConcat3(s1:='ls ', s2:=GPLC.plc.baseFilePath,s3:=' | wc -l'), result=> ));
///dirBuffer							:=		SysDir.SysDirOpen(szDir:=GPLC.plc.baseFilePath,szDirEntry:=foundDirEntry,diMaxDirEntry:=SIZEOF(foundDirEntry),pDirInfo:=ADR(foundDirInfoBuffer) ,pResult:=ADR(foundFileResult));
IF dirBuffer <> 0 AND TO_DWORD(dirBuffer) <> 4294967295 THEN
	WHILE TRUE DO
		foundFileResult				:=		SysDir.SysDirRead(hDir:=dirBuffer,szDirEntry:=foundDirEntry,diMaxDirEntry:=SIZEOF(foundDirEntry),pDirInfo:=ADR(foundDirInfoBuffer));
		IF foundFileResult <> 0 THEN
			EXIT;
		END_IF
		sysAmountFiles				:=		sysAmountFiles + 1;
	END_WHILE
END_IF

//If the command line count a different amount of entries in the directory than the sysDir, then the bug is active, and the system should be rebootet
IF cmdAmountFiles <> sysAmountFiles THEN
	executeShellCommand(command:='sudo reboot');
END_IF

//Creates user for external access
IF NOT(checkUserExists(user:='external')) THEN
	createUser(user:='external', passwd:='LYNGAAEXTERNAL');
	FU_changeFileFolderAccess(path:='/home/codesys_root',ownerRead:=TRUE,ownerWrite:=TRUE,ownerExecute:=TRUE,groupRead:=TRUE,groupWrite:=TRUE,groupExecute:=TRUE,publicRead:=FALSE,publicWrite:=FALSE,publicExecute:=TRUE);
	executeShellCommand(command:='sed -i $'/DAEMON_OPTIONS/s/=.*/="-C 10 -E -p 32000:32100 -b -a 1002"/$' /etc/init.d/pureftpd');
	setUpReboot						:=		TRUE;
END_IF

//Creates user for external access
IF executeShellCommand(command:='printf "$$(head /etc/lighttpd/redirect_default.conf -n1)"') <> 'url.redirect-code = 307' THEN
	executeShellCommand(command:='truncate -s 1612 /etc/lighttpd/lighttpd.conf');
	executeShellCommand(command:='printf "url.redirect-code = 307\nurl.redirect = (\n  \"^/$$\" => \"/webvisu/LMUI.html\",\n  \"^/webvisu/$$\" => \"/webvisu/LMUI.html\"\n)" > /etc/lighttpd/redirect_default.conf');
	executeShellCommand(command:='mkdir /home/codesys_root/LMUI');
	executeShellCommand(command:='rm -r /var/www/webvisu');
	executeShellCommand(command:='ln -s /home/codesys_root/LMUI /var/www/webvisu');
	setUpReboot						:=		TRUE;
END_IF

IF setUpReboot THEN
	executeShellCommand(command:='sudo reboot');	
END_IF

//Addition to data server
//GDataServer.dataServer.addCommandController(controllerModule:=THIS^,commandCode:=EASCII.BigS);

//Manager adds itself to list
_SID							:=		1;
resultBuffer					:=		loadModule(module:=THIS);
IF NOT(resultBuffer.success) THEN
	saveModule(module:=THIS,dontLog:=TRUE);
END_IF
_UID							:=		1;
registerModuleByUID(module:=THIS);
addToOrderedList(module:=THIS);

