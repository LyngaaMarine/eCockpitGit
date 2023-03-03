{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM PRG_BootManager
VAR_INPUT
	pouSpeed				:WORD;
END_VAR
VAR_OUTPUT
	bootFinished			:BOOL;				//True when boot is finished
END_VAR
VAR
	bootFailed				:BOOL;				//True when boot is finished
	bootResultCode			:SLMResult;			//The result code of the thing booting
	bootProg				:INT;				//The initial wait before the boot is started	
	bootCounter				:INT;				//The initial wait before the boot is started
END_VAR

!__IMPLEMENTATION__!
IF NOT(bootFinished) AND NOT(bootFailed) THEN
	CASE bootProg OF
		0:	initProject();
			ProjectBeforeBoot();
			///Logs.initLogs();
		1:	bootResultCode		:=		GMod.modMan.initializeManager();
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GAlarm.alarmSystem)		,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GPLC.plc)					,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GIO.ioSystem)				,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GUsers.management)			,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GDataServer.dataServer)	,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GLicense.licenseSystem)	,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GModules.modules)			,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
///			bootResultCode		:=		GMod.modMan.registerModule(moduleBuffer:=ADR(GWago.localCards)			,parentModule:=ADR(GMod.modMan)	,access:=GUsers.userAndPublicRead	,subID:=0	,mid:=0	,client:=0);
		2:	ProjectDuringBoot(pouSpeed:=pouSpeed);
		3:	bootResultCode		:=		GMod.modMan.initializeModules(pouSpeed:=pouSpeed);
		4:	bootFinished		:=		TRUE;
			Management.releaseExclusiveManagementTask();
			RETURN;
	END_CASE
	IF bootResultCode.success THEN
		IF bootResultCode.code = ERCodes.MoreTime THEN
			RETURN;
		ELSE
			bootProg			:=		bootProg + 1;
		END_IF
	ELSE
		bootFailed				:=		TRUE;
	END_IF
END_IF