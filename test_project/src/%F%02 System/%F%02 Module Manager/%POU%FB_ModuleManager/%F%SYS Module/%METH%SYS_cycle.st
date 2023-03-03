{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": true, "enable_system_call": false}
//This method is the managment cycle of the module manager
//I handles saving, deleting, moving modules
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 21-09-20 | Creation
METHOD SYS_cycle
VAR_IN_OUT
	pouSpeed			:WORD;
END_VAR
VAR
	module				:AModule;
	i					:WORD;
	timeResult			:SysTypes.RTS_IEC_RESULT;
	index				:DWORD;
END_VAR
!__IMPLEMENTATION__!
IF S_threadSafeActive THEN
	IF Management.checkExclusiveManagementTask() THEN
		IF S_dataFIFO.isNotEmpty THEN
			IF S_dataFIFO.unshiftStart(index=>index) THEN
				processMangementEvent(
					event			:=		S_dataBuffer[index].event,
					client			:=		S_dataBuffer[index].client,
					module			:=		S_dataBuffer[index].module,
					mid				:=		S_dataBuffer[index].mid,
					des				:=		S_dataBuffer[index].des,
					data			:=		ADR(S_dataBuffer[index].data),
					dataLen			:=		S_dataBuffer[index].dataSize
				);
				S_dataFIFO.unshiftEnd();
			END_IF
		ELSIF S_noDataFIFO.isNotEmpty THEN
			IF S_noDataFIFO.unshiftStart(index=>index) THEN
				processMangementEvent(
					event			:=		S_noDataBuffer[index].event,
					client			:=		S_noDataBuffer[index].client,
					module			:=		S_noDataBuffer[index].module,
					mid				:=		S_noDataBuffer[index].mid,
					des				:=		S_noDataBuffer[index].des,
					data			:=		0,
					dataLen			:=		0
				);
				S_noDataFIFO.unshiftEnd();
			END_IF
		ELSE
			Management.releaseExclusiveManagementTask();
			S_threadSafeActive				:=		FALSE;
		END_IF
	END_IF
ELSE
	//Time is retrieved from system
	S_currentTimeDWORD						:=		SysTimeRtc.SysTimeRtcGet(pResult:=timeResult);	//System time in seconds is calculated
	S_currentTimeDT							:=		TO_DT(S_currentTimeDWORD);			//The system time is read from the RTC
	S_currentTimeInt						:=		TO_STRING(S_currentTimeDT);			//The system time is read from the RTC
	S_upTime								:=		S_currentTimeDWORD - S_bootTime;

	IF S_updateModuleFIFO.isNotEmpty THEN
		FOR	i := i TO 9 DO
			IF S_updateModuleFIFO.unshiftStart(index=>index) THEN
				module			:=		getModuleByUID(modUID:=S_updateModuleBuffer[index].moduleUID);
				IF module <> 0 THEN
					updateClients(client:=S_updateModuleBuffer[index].clientUID,mid:=S_updateModuleBuffer[index].mid,module:=module);
				END_IF
				S_updateModuleFIFO.unshiftEnd();
			ELSE
				EXIT;
			END_IF
		END_FOR
	END_IF
	
	IF S_saveModuleFIFO.isNotEmpty THEN
		FOR	i := i TO 9 DO
			IF S_saveModuleFIFO.unshiftStart(index=>index) THEN
				module			:=		getModuleByUID(modUID:=S_saveModuleBuffer[index].moduleUID);
				IF module <> 0 THEN
					saveModule(module:=module,dontLog:=S_saveModuleBuffer[index].dontLog);
				END_IF
				S_saveModuleFIFO.unshiftEnd();
			ELSE
				EXIT;
			END_IF
		END_FOR
	END_IF
	
	IF S_dataFIFO.isNotEmpty OR S_noDataFIFO.isNotEmpty THEN
		Management.requestExclusiveManagementTask();
		S_threadSafeActive		:=		TRUE;
	END_IF
END_IF