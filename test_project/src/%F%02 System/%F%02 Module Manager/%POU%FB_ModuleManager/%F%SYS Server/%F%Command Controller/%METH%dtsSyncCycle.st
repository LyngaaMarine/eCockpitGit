//This method is called when the the command controller is in cyclic mode to sync
//It is run in the data servers task, so don't do anything to intensive
METHOD dtsSyncCycle : SLMResult
VAR_IN_OUT
	commander		:FB_DataServerCommander;			//This carries the data commander containing the data
	client			:FB_DataServerClient;				//This carries the client
END_VAR
VAR_INPUT
	pouSpeed		:WORD;
	reservedData	:POINTER TO BYTE;					//This is a reference to the data reserved for the command controller
END_VAR
VAR_OUTPUT
	keepCycle		:BOOL;		//This must be set true as long as the cycle should go, when not set or set false the cycle ends
END_VAR
VAR
	i				:BYTE;
	desBuff			:AModuleDes;
	modBuff			:POINTER TO FB_Module;
	resBuff			:SLMResult;
END_VAR

(*%!%__DELIMITER__%!%*)
IF reservedData <> 0 THEN
	keepCycle																	:=		TRUE;
	//This sends the data initializations data
	IF __CAST(reservedData^,SModManDataClientData).dataInitProgress > 0 THEN
		//This resets the data buffer on first run
		IF __CAST(reservedData^,SModManDataClientData).dataInitRuns = 0 THEN
			FU_ClearData(data:=__CAST(reservedData^,SModManDataClientData).dataInitBuffer);
		END_IF
		IF GDataServer.dataServer.dataInitializers[__CAST(reservedData^,SModManDataClientData).dataInitProgress - 1] <> 0 THEN
			commander.writeReset();
			commander.writeAddTypeCode(char:=EASCII.BigS);
			commander.writeAddTypeCode(char:=EASCII.BigI);
			commander.writeJSONInit(jsonType:=EStructType.object);
			commander.jSONWriter.addKey(name:=GTSmall.Sdes);
			desBuff		:=		GDataServer.dataServer.dataInitializers[__CAST(reservedData^,SModManDataClientData).dataInitProgress - 1]^.SYS_designator;
			commander.jSONWriter.writeString(value:=ADR(desBuff));
			resBuff		:=		GDataServer.dataServer.dataInitializers[__CAST(reservedData^,SModManDataClientData).dataInitProgress - 1]^.SYS_serverInitData(writer:=commander.jSONWriter,client:=ADR(client),reservedData:=ADR(__CAST(reservedData^,SModManDataClientData).dataInitBuffer));
			client.sendData(commander:=commander);
			IF resBuff.code = ERCodes.Finished THEN
				__CAST(reservedData^,SModManDataClientData).dataInitProgress	:=		__CAST(reservedData^,SModManDataClientData).dataInitProgress + 1;
				__CAST(reservedData^,SModManDataClientData).dataInitRuns		:=		0;
				RETURN;
			END_IF
			__CAST(reservedData^,SModManDataClientData).dataInitRuns			:=		__CAST(reservedData^,SModManDataClientData).dataInitRuns + 1;
			RETURN;
		ELSE
			__CAST(reservedData^,SModManDataClientData).dataInitProgress		:=		0;
			__CAST(reservedData^,SModManDataClientData).moduleSyncProgress		:=		1;
			RETURN;
		END_IF
	END_IF
	
	//This sends all the modules
	IF __CAST(reservedData^,SModManDataClientData).moduleSyncProgress > 0 THEN
		FOR i := 1 TO 20 DO
			modBuff					:=		S_modulesInOrder[__CAST(reservedData^,SModManDataClientData).moduleSyncProgress];
			commander.writeReset();
			commander.writeAddTypeCode(char:=EASCII.BigS);
			IF __CAST(reservedData^,SModManDataClientData).moduleSyncProgress <= S_modulesAmount THEN
				commander.writeAddTypeCode(char:=EASCII.BigO);
				commander.writeJSONInit(jsonType:=EStructType.object);
				packModule(module:=modBuff,writer:=commander.jSONWriter,client:=ADR(client));
				client.sendData(commander:=commander);
			ELSE
				commander.writeAddTypeCode(char:=EASCII.BigD);
				commander.writeJSONInit(jsonType:=EStructType.object);
				commander.jSONWriter.addKey(name:=GTSmall.Snum);
				commander.jSONWriter.writeDint(value:=GMod.modMan.S_moduleUpdate);
				client.sendData(commander:=commander);
				__CAST(reservedData^,SModManDataClientData).moduleSyncProgress		:=		0;
				__CAST(reservedData^,SModManDataClientData).dataInitProgress		:=		0;
				keepCycle															:=		FALSE;
				EXIT;
			END_IF
			__CAST(reservedData^,SModManDataClientData).moduleSyncProgress			:=		__CAST(reservedData^,SModManDataClientData).moduleSyncProgress + 1;
		END_FOR
	END_IF

END_IF