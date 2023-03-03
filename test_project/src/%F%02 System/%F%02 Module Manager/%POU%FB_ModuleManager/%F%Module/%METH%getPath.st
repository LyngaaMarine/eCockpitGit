//This method gets the path of an module
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-09-19 | Creation
METHOD getPath : aPath
VAR_INPUT
	module			:POINTER TO FB_Module;
	dirPath			:BOOL;			//Set true to get the directory path for the module
END_VAR
VAR
	i				:BYTE;
	nameBuffer		:AModuleName;
END_VAR
(*%!%__DELIMITER__%!%*)
//The module is gotten
FOR i := 1 TO GConstants.maxDepth DO
	//Path for module is created
	IF NOT(dirPath) THEN
		IF i = 1 THEN
			getPath				:=		'.json';			
		ELSE
			getPath				:=		FU_sConcat(s1:=GUTF8.Solidus,s2:=getPath);	
		END_IF
	ELSE
		IF i > 1 THEN
			getPath				:=		FU_sConcat(s1:=GUTF8.Solidus,s2:=getPath);	
		END_IF
	END_IF
	//Save name is generated
	nameBuffer					:=		module^.SYS_saveName();
	IF nameBuffer = '' THEN
		getPath					:=		FU_sConcat(s1:=module^.SYS_designator,s2:=getPath);
	ELSIF nameBuffer = 'sub' THEN
		getPath					:=		FU_sConcat5(s1:='S',s2:=FU_sPaddFrontLen(sStr:=TO_STRING(module^._SID),wLen:=3,eChar:=EASCII.Zero),s3:=GUTF8.SemiColon,s4:=module^.SYS_designator,s5:=getPath);
	ELSE
		getPath					:=		FU_sConcat4(s1:=nameBuffer,s2:=GUTF8.SemiColon,s3:=module^.SYS_designator,s4:=getPath);
	END_IF
	//Parent id is gotten
	module						:=		module^.SYS_parent;
	//If parent is bottom, the loop is ended
	IF module = 0 THEN
	///	getPath					:=		FU_sConcat(s1:=GPLC.plc.baseFilePath,s2:=getPath);
		RETURN;
	END_IF
END_FOR