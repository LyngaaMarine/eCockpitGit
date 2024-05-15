{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This adds the path for the log
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 19-09-20 | Creation
METHOD PROTECTED logChange
VAR_INPUT
	valType			:ESysType;
	valPoint		:POINTER TO USysTypes;
END_VAR
VAR
	i				:BYTE;
	levelBuffer		:BYTE;
	stringBuffer	:STRING(200);
	writer			:FB_JSONWriter;
	lenght			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF doLogInt THEN
	IF selectedType = EStructType.tArray THEN
		keyFound	:=		reader.nextArray() <> EStructType.none;
	END_IF
	IF NOT(dontLog) AND keyFound THEN
		CASE valType OF
			ESysType.tBool:
				IF reader.valueType = EStructType.tBool AND_THEN valPoint^.bBOOL = reader.readBool() THEN
					RETURN;
				END_IF
				
			//Bytes
			ESysType.tBYTE,ESysType.tUSINT:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bBYTE = reader.readDword() THEN
					RETURN;
				END_IF
	
			ESysType.tWORD,ESysType.tUINT:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bWORD = reader.readDword() THEN
					RETURN;
				END_IF
				
			ESysType.tDWORD,ESysType.tUDINT:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bDWORD = reader.readDword() THEN
					RETURN;
				END_IF
		
			//INTs
			ESysType.tSINT:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bSINT = reader.readDint() THEN
					RETURN;
				END_IF
			ESysType.tINT:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bINT = reader.readDint() THEN
					RETURN;
				END_IF
			ESysType.tDINT:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bDINT = reader.readDint() THEN
					RETURN;
				END_IF				
				
			ESysType.tReal:
				IF reader.valueType = EStructType.number AND_THEN valPoint^.bREAL = reader.readReal() THEN
					RETURN;
				END_IF
			ESysType.tNONE:
				IF reader.valueType = EStructType.null THEN
					RETURN;
				END_IF
			ESysType.tString:
				IF reader.valueType = EStructType.tString AND_THEN reader.compareString(str:=valPoint) THEN
					RETURN;
				END_IF
		END_CASE
			
		
		writer.addKey(name:=GTSmall.Stime);
		
		writer.addKey(name:=GTSmall.Stype);
		writer.writeString(value:=GTSmall.Schanged);
		
		levelBuffer		:=		reader.amountLevels;
		IF levelBuffer > 0 THEN
			writer.addKey(name:=GTSmall.Spath);
			writer.arrayStart(singleLine:=TRUE);
			FOR i := 1 TO levelBuffer DO
				reader.readKeyNameLevel(name:=ADR(stringBuffer),lenMax:=SIZEOF(stringBuffer)-1,level:=i,len=>lenght);
				IF writer.bufferLeft > lenght + 250 THEN
					writer.writeString(value:=ADR(stringBuffer));
				END_IF
			END_FOR
			writer.structEnd();
		END_IF
		
		writer.addKey(name:=GTSmall.Sold);
		CASE reader.valueType OF
			EStructType.tBool:
				writer.writeBool(value:=reader.readBool());
			EStructType.number:
				reader.readString(str:=ADR(stringBuffer),lenMax:=SIZEOF(stringBuffer) - 1);
				writer.writeRaw(ADR(stringBuffer));
			EStructType.null:
				writer.writeNull();
			EStructType.tString:
				reader.readString(str:=ADR(stringBuffer),lenMax:=SIZEOF(stringBuffer) - 1);
				writer.writeString(value:=ADR(stringBuffer));
		END_CASE
		
		writer.addKey(name:=GTSmall.Snew);
		CASE valType OF
			ESysType.tBool:
				writer.writeBool(value:=valPoint^.bBOOL);
			//Bytes
			ESysType.tBYTE,ESysType.tUSINT:
				writer.writeDword(value:=valPoint^.bBYTE);
			ESysType.tWORD,ESysType.tUINT:
				writer.writeDword(value:=valPoint^.bWORD);
			ESysType.tDWORD,ESysType.tUDINT:
				writer.writeDword(value:=valPoint^.bDWORD);
		
			//INTs
			ESysType.tSINT:
				writer.writeDint(value:=valPoint^.bSINT);
			ESysType.tINT:
				writer.writeDint(value:=valPoint^.bINT);
			ESysType.tDINT:
				writer.writeDint(value:=valPoint^.bDINT);
				
				
			ESysType.tReal:
				writer.writeReal(value:=valPoint^.bREAL);
			ESysType.tNONE:
				writer.writeNull();
			ESysType.tString:
				writer.writeString(value:=valPoint);
		END_CASE
		
		writer.deinitialize();
		
		//writer.writeFile(path:=Logs.moduleLog.addLog());
	END_IF
END_IF