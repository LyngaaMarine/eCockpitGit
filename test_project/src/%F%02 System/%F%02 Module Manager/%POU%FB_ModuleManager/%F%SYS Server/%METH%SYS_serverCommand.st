{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method is called for module commands, any response created is send back
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 28-11-20 | Creation
METHOD SYS_serverCommand : SLMResult
VAR_INPUT
	client		:POINTER TO FB_DataServerClient;
	reader		:ITF_StructReaderBase;
	writer		:ITF_StructWriterBase;
END_VAR
VAR
 	modBuff		:POINTER TO FB_Module;
 	rawPos		:POINTER TO BYTE;
 	rawLen		:DWORD;
END_VAR
!__IMPLEMENTATION__!
WHILE reader.nextKey() <> EStructType.none DO
	IF reader.compareKeyName(name:=GTSmall.Sping) <> EStructType.none THEN
		SYS_serverCommand.code				:=		ERCodes.CommandResponseSendData;
		writer.addKey(name:=GTSmall.Sping);
		writer.arrayStart(singleLine:=TRUE);
		writer.writeString(value:=GTLists.structTypes[reader.valueType]);
		CASE reader.valueType OF
			EStructType.null,EStructType.number,EStructType.tBool,EStructType.tString,EStructType.object,EStructType.tArray:
				reader.exportValue(position=>rawPos,size=>rawLen);
				writer.writeRawLen(value:=rawPos,len:=rawLen);
			EStructType.invalid,EStructType.none:;
		END_CASE
	END_IF
	IF reader.compareKeyName(name:=GTSmall.Sname) <> EStructType.none THEN
		modBuff								:=		GMod.modMan.getModuleByUID(ModUID:=reader.readWord());
		IF modBuff <> 0 THEN
			SYS_serverCommand.code			:=		ERCodes.CommandResponseSendData;
			writer.addKey(name:=GTSmall.Sname);
			GMod.modMan.structWriteModuleName(module:=modBuff,writer:=writer,mode:=0);
		END_IF
	END_IF
END_WHILE
