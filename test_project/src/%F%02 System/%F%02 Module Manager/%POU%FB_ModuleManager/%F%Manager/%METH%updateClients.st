METHOD updateClients
VAR_INPUT
	module			:POINTER TO FB_Module;
	client			:AModuleUID;
	mid				:AMessageID;
END_VAR

(*%!%__DELIMITER__%!%*)
IF module = 0 THEN
	RETURN;
END_IF
S_commander.writeReset();
S_commander.writeAddTypeCode(char:=EASCII.BigS);
S_commander.writeAddTypeCode(char:=EASCII.BigO);
S_commander.writeJSONInit(jsonType:=EStructType.object);
IF client <> 0 THEN
	S_commander.jSONWriter.addKey(name:=GTSmall.Sclient);
	S_commander.jSONWriter.writeDint(value:=client);
END_IF
IF mid <> 0 THEN
	S_commander.jSONWriter.addKey(name:=GTSmall.Smid);
	S_commander.jSONWriter.writeDint(value:=mid);
END_IF
packModule(module:=module,writer:=S_commander.jSONWriter,client:=0);
GDataServer.dataServer.globalSendCommand(commander:=S_commander,needSynced:=FALSE);