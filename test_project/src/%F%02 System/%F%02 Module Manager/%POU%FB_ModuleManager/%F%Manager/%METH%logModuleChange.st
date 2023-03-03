{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method makes logging module changes simpler
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-19 | Creation
METHOD logModuleChange
VAR_INPUT
	module			:POINTER TO FB_Module;
	logType			:BYTE;
END_VAR
VAR
	pathBuff		:APath;
	///writeBuffer		:STRING(Logs.modLogBufferSize);
	writer			:FB_JSONWriter;	//For loading and saving modules
END_VAR
!__IMPLEMENTATION__!
IF module <> 0 THEN
	///writer.initialize(buffer:=ADR(writeBuffer),bufferSize:=Logs.modLogBufferSize,singleLine:=TRUE,bottomType:=EStructType.object);
	
	writer.addKey(name:=GTSmall.Stime);
	writer.writeString(value:=GMod.modMan.S_currentTime);

	writer.addKey(name:=GTSmall.Stype);
	CASE logType OF
		//Module deletion
		0: 	writer.writeString(value:=GTSmall.Sdeleted);
		//Module creation
		1:	writer.writeString(value:=GTSmall.Screation);
		//Module moved
		2:	writer.writeString(value:=GTSmall.Smoved);
	END_CASE
	
	writer.addKey(name:=GTSmall.Suid);
	writer.writeWord(value:=module^._UID);

	writer.addKey(name:=GTSmall.Sdes);
	structWriteDesignator(module:=module,writer:=writer);

	CASE logType OF
		//Module deletion
		0:
			writer.addKey(name:=GTSmall.Sname);
			GMod.modMan.structWriteModuleName(module:=module,writer:=writer,mode:=0);
		//Module creation
		1:	
			writer.addKey(name:=GTSmall.Sparent);
			IF module^.SYS_parent <> 0 THEN
				writer.writeWord(value:=module^.SYS_parent^._UID);
			ELSE
				writer.writeWord(value:=0);
			END_IF
		2:
			writer.addKey(name:=GTSmall.Sto);
			IF module^.SYS_parent <> 0 THEN
				writer.writeWord(value:=module^.SYS_parent^._UID);
			ELSE
				writer.writeWord(value:=0);
			END_IF
	END_CASE
	writer.deinitialize();
	
	///writer.writeFile(path:=Logs.moduleLog.addLog());
END_IF