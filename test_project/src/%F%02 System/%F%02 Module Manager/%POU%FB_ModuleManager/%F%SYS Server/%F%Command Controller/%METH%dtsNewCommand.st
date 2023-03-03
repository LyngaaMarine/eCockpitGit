//This method is called when the data client has a new command
//It is run in the data servers task, so don't do anything to intensive
METHOD dtsNewCommand : SLMResult
VAR_IN_OUT
	commander			:FB_DataServerCommander;			//This carries the data commander containing the data
	client				:FB_DataServerClient;				//This carries the client
END_VAR
VAR_INPUT
	reservedData		:POINTER TO BYTE;					//This is a reference to the data reserved for the command controller
END_VAR
VAR_OUTPUT
	needCycle			:BOOL;		//Set this true to be added to the cyclic sync functionality
END_VAR
VAR
	modBuff				:POINTER TO FB_Module;
	midBuff				:AMessageID;
	data				:POINTER TO EASCII;
	dataLen				:DWORD;
	modIDBuff			:AModuleUID;
	modDes				:AModuleDes;
	modIDString			:STRING(5);
	typeCodeBuffer		:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
commander.writeAddTypeCode(char:=EASCII.BigS);
CASE commander.readTypeCode() OF
	EASCII.BigN:
		commander.writeAddTypeCode(char:=EASCII.BigN);
		commander.writeJSONInit(jsonType:=EStructType.object);
		commander.jSONWriter.addKey(name:=GTSmall.Snum);
		commander.jSONWriter.writeDint(value:=S_moduleUpdate);
		commander.jSONWriter.addKey(name:=GTSmall.Samount);
		commander.jSONWriter.writeDint(value:=S_modulesAmount);
		structWriteModuleName(module:=THIS,writer:=commander.jSONWriter,mode:=0);
		client.sendData(commander:=commander);
	EASCII.BigS:
		commander.writeAddTypeCode(char:=EASCII.BigS);
		commander.writeJSONInit(jsonType:=EStructType.object);
		commander.jSONWriter.addKey(name:=GTSmall.Snum);
		commander.jSONWriter.writeDint(value:=S_moduleUpdate);
		commander.jSONWriter.addKey(name:=GTSmall.Samount);
		commander.jSONWriter.writeDint(value:=S_modulesAmount);
		commander.jSONWriter.addKey(name:=GTSmall.Sname);
		structWriteModuleName(module:=THIS,writer:=commander.jSONWriter,mode:=0);
		commander.jSONWriter.addKey(name:=GTSmall.Stime);
		commander.jSONWriter.writeDword(value:=GMod.modMan.S_currentTimeDWORD);
		client.sendData(commander:=commander);
		__CAST(reservedData^,SModManDataClientData).dataInitProgress			:=		1;
		needCycle		:=		TRUE;
	EASCII.Smalld:		//Update that the ui is finished syncing modules
		client.synced			:=		TRUE;
	EASCII.BigD:		//Request for deleting module
		commander.writeAddTypeCode(char:=EASCII.BigR);
		CASE commander.jSONReader.selectedType OF
			EStructType.object:
				IF commander.jSONReader.findKey(name:=GTSmall.SmodID) <> EStructType.none THEN
					//Module is found
					modBuff		:=		getModuleByUID(ModUID:=commander.jSONReader.readWord());
					IF modBuff <> 0 THEN
						//Check if access is enough to delete
						IF GUsers.management.getAccessByClientAndModuleType(client:=ADR(client),module:=modBuff,accessType:=EAccessType.config) THEN
							commander.jSONReader.findKey(name:=GTSmall.Snum);
							GMod.modMan.queryManagementEvent(event:=EManagementEvent.Delete,module:=modBuff^._UID,client:=client._UID,des:='',mid:=commander.jSONReader.readWord(),data:=0,dataLen:=0);
						ELSE
							commander.writeAddTypeCode(char:=EASCII.BigN);
							client.sendData(commander:=commander);
						END_IF
					ELSE
						commander.writeAddTypeCode(char:=EASCII.BigE);
						client.sendData(commander:=commander);
					END_IF
				END_IF
		END_CASE
	EASCII.BigC:
		commander.writeAddTypeCode(char:=EASCII.BigC);
		IF commander.jSONReader.selectedType = EStructType.object THEN
			IF commander.jSONReader.findKey(name:=GTSmall.SmodID) = EStructType.none THEN
				commander.writeAddTypeCode(char:=EASCII.BigE);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			modBuff							:=		GMod.modMan.getModuleByUID(ModUID:=commander.jSONReader.readWord());
			IF modBuff = 0 THEN
				commander.writeAddTypeCode(char:=EASCII.BigE);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			IF NOT(GUsers.management.getAccessByClientAndModuleType(client:=ADR(client),module:=modBuff,accessType:=EAccessType.config)) THEN
				commander.writeAddTypeCode(char:=EASCII.BigN);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			IF commander.jSONReader.findKey(name:=GTSmall.Smid) <> EStructType.none THEN
				midBuff						:=		commander.jSONReader.readWord();
			END_IF
			IF commander.jSONReader.findKey(name:=GTSmall.Sdata) <> EStructType.object THEN
				commander.writeAddTypeCode(char:=EASCII.BigC);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			commander.jSONReader.enterObjectArray();
			commander.jSONReader.exportSelection(position=>data,size=>dataLen);	
			commander.jSONReader.enterObjectArray();
			queryManagementEvent(event:=EManagementEvent.Config,client:=client._UID,module:=modBuff^._UID,mid:=midBuff,des:='',data:=data,dataLen:=dataLen);
		END_IF
	EASCII.BigM:
		commander.writeAddTypeCode(char:=EASCII.BigM);
		IF commander.jSONReader.selectedType = EStructType.object THEN
			IF commander.jSONReader.findKey(name:=GTSmall.SmodID) = EStructType.none THEN
				commander.writeAddTypeCode(char:=EASCII.BigE);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			modBuff							:=		GMod.modMan.getModuleByUID(ModUID:=commander.jSONReader.readWord());
			IF modBuff = 0 THEN
				commander.writeAddTypeCode(char:=EASCII.BigE);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			IF NOT(GUsers.management.getAccessByClientAndModuleType(client:=ADR(client),module:=modBuff,accessType:=EAccessType.viewing)) THEN
				commander.writeAddTypeCode(char:=EASCII.BigN);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			commander.writeJSONInit(jsonType:=EStructType.object);
			commander.jSONWriter.addKey(name:=GTSmall.SmodID);
			commander.jSONWriter.writeDint(value:=modBuff^._UID);
			commander.jSONWriter.addKey(name:=GTSmall.Sdata);
			commander.jSONWriter.objectStart(singleLine:=TRUE);
			exportModuleConfig(module:=modBuff,writer:=commander.jSONWriter);
			commander.jSONWriter.structEnd();
			client.sendData(commander:=commander);
		END_IF
	EASCII.BigA:
		commander.writeAddTypeCode(char:=EASCII.BigA);
		IF commander.jSONReader.selectedType = EStructType.object THEN
			IF commander.jSONReader.findKey(name:=GTSmall.SmodID) = EStructType.none THEN
				commander.writeAddTypeCode(char:=EASCII.BigE);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			modBuff							:=		GMod.modMan.getModuleByUID(ModUID:=commander.jSONReader.readWord());
			IF modBuff = 0 THEN
				commander.writeAddTypeCode(char:=EASCII.BigE);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			IF commander.jSONReader.findKey(name:=GTSmall.Sdes) <> EStructType.tString THEN
				commander.writeAddTypeCode(char:=EASCII.BigD);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			commander.jSONReader.readString(str:=ADR(modDes),lenMax:=SIZEOF(modDes)-1);
			IF NOT(GUsers.management.getAccessByClientAndModuleType(client:=ADR(client),module:=modBuff,accessType:=EAccessType.config)) THEN
				commander.writeAddTypeCode(char:=EASCII.BigN);
				client.sendData(commander:=commander);
				RETURN;
			END_IF
			IF commander.jSONReader.findKey(name:=GTSmall.Smid) <> EStructType.none THEN
				midBuff						:=		commander.jSONReader.readWord();
			END_IF
			IF commander.jSONReader.findKey(name:=GTSmall.Sdata) = EStructType.object THEN
				commander.jSONReader.enterObjectArray();
				commander.jSONReader.exportSelection(position=>data,size=>dataLen);	
				commander.jSONReader.enterObjectArray();
				queryManagementEvent(event:=EManagementEvent.Creation,client:=client._UID,module:=modBuff^._UID,mid:=midBuff,des:=modDes,data:=data,dataLen:=dataLen);
			ELSE
				queryManagementEvent(event:=EManagementEvent.Creation,client:=client._UID,module:=modBuff^._UID,mid:=midBuff,des:=modDes,data:=0,dataLen:=0);	
			END_IF
			
		END_IF
		
	//Module status values
	EASCII.Smalls:
		commander.writeAddTypeCode(char:=EASCII.Smalls);
		IF commander.jSONReader.selectedType = EStructType.tArray THEN
			commander.writeJSONInit(jsonType:=EStructType.object);
			commander.jSONReader.enterObjectArray();
			WHILE commander.jSONReader.nextArray() <> EStructType.none DO
				modBuff						:=		GMod.modMan.getModuleByUID(ModUID:=commander.jSONReader.readWord());
				IF modBuff <> 0 THEN
					modIDString				:=		TO_STRING(modBuff^._UID);
					commander.jSONWriter.addKey(name:=ADR(modIDString));
					commander.jSONWriter.arrayStart(singleLine:=TRUE);
					modBuff^.SYS_status(writer:=commander.jSONWriter,client:=THIS);
					commander.jSONWriter.structEnd();
				END_IF
			END_WHILE
			client.sendData(commander:=commander);
		END_IF
		
	//This handles single time value getting
	EASCII.BigV:
		commander.writeAddTypeCode(char:=EASCII.BigV);
		commander.writeJSONInit(jsonType:=EStructType.object);
		CASE commander.jSONReader.selectedType OF
			EStructType.tArray:
				WHILE commander.jSONReader.nextArray() = EStructType.number DO
					modIDBuff							:=		commander.jSONReader.readWord();
					modIDString							:=		TO_STRING(modIDBuff);
					commander.jSONWriter.addKey(name:=ADR(modIDString));
					packValue(modID:=modIDBuff,writer:=commander.jSONWriter);
				END_WHILE
			EStructType.number:
				modIDBuff								:=		commander.jSONReader.readWord();
				modIDString								:=		TO_STRING(modIDBuff);
				commander.jSONWriter.addKey(name:=ADR(modIDString));
				packValue(modID:=modIDBuff,writer:=commander.jSONWriter);
		ELSE
			RETURN;
		END_CASE
		client.sendData(commander:=commander);
	//This command sets the value of an module
	EASCII.BigP:
		CASE commander.jSONReader.selectedType OF
			EStructType.object:
				WHILE commander.jSONReader.nextKey() <> EStructType.none DO
					commander.jSONReader.readKeyName(name:=ADR(modIDString),lenMax:=5);
					modBuff								:=		GMod.modMan.getModuleByUID(ModUID:=TO_WORD(modIDString));
					IF modBuff <> 0 THEN
						IF GUsers.management.getAccessByClientAndModuleType(client:=ADR(client),module:=modBuff,accessType:=EAccessType.value) THEN
							moduleValueReadFromStruct(module:=modBuff,reader:=commander.jSONReader);
						END_IF
					END_IF
				END_WHILE
		END_CASE
		commander.jSONReader.deinitialize();
END_CASE