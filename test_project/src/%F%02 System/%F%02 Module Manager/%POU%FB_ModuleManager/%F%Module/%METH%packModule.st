//This method packs the module into a struct
//Super should always be called on this method
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 28-11-20 | Creation
METHOD packModule : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	client		:POINTER TO FB_DataServerClient;
	writer		:ITF_StructWriterBase;
END_VAR
VAR
	valType		:EValueType;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.addKey(name:=GTSmall.Snum);
writer.writeDint(value:=GMod.modMan.S_moduleUpdate);
writer.addKey(name:=GTSmall.Suid);
writer.writeDint(value:=module^._UID);
writer.addKey(name:=GTSmall.Spid);
IF module^._parent <> 0 THEN
	writer.writeDint(value:=module^._parent^._UID);
ELSE
	writer.writeDint(value:=0);
END_IF
writer.addKey(name:=GTSmall.Ssid);
writer.writeDint(value:=module^._SID);
writer.addKey(name:=GTSmall.Sdes);
structWriteDesignator(module:=module,writer:=writer);
IF module^._name <> 0 THEN
	writer.addKey(name:=GTSmall.Sname);
	structWriteModuleName(module:=module,writer:=writer,mode:=1);
END_IF
writer.addKey(name:=GTSmall.Suser);
writer.writeDint(value:=module^._access.asStruct.user);
writer.addKey(name:=GTSmall.Suser2);
writer.writeDint(value:=module^._access.asStruct.user2);
writer.addKey(name:=GTSmall.Saccess);
writer.writeDword(value:=module^._access.asStruct.sstruct.asWord);
IF module^._unit <> 0 THEN
	writer.addKey(name:=GTSmall.Sunit);
	writeModuleUnitToStruct(module:=module,writer:=writer,mode:=1);
END_IF
writer.addKey(name:=GTSmall.Sva);
writer.writeDint(value:=module^.SYS_valueAccess);
writer.addKey(name:=GTSmall.Svt);
valType			:=		module^.SYS_valueType;
writer.writeDint(value:=valType);
CASE valType OF
	EValueType.signed32,EValueType.signed64,EValueType.enum,EValueType.float32,EValueType.unsigned32,EValueType.unsigned64:	structWriteMinMaxModule(module:=module,writer:=writer);
END_CASE
module^.SYS_packModule(client:=client,writer:=writer);