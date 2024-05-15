{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This initializes the manager with the correct values
//Returns code for result, 0 = OK, 1 = File doesn't exist, but created, 2 = File doesn't exist, 3 = File doesn't exist, and cannot be created, 4 = Unknown file error
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-06-18 | Creation
METHOD LSStart: SLMResult 
VAR_INPUT
	sFilePath			:APath;				//Path to save file
	xReadWrite			:BOOL;				//Set False when reading data, True when writing data
	dontLog				:BOOL;
END_VAR
VAR
	amountRead			:UDINT;
	fileResultCode		:SysTypes.RTS_IEC_RESULT;
	fileHandle			:SysTypes.RTS_IEC_HANDLE;
	fileFound			:BOOL;
END_VAR
!__IMPLEMENTATION__!
IF sFilePath <> '' AND NOT(started) THEN
	fileFound					:=		FALSE;

	//When reading a found file is needed, when writing or simulating no file is needed
	IF LSStart.success OR xReadWrite THEN
		filePath				:=		sFilePath;
		readWrite				:=		xReadWrite;
		started					:=		TRUE;
		logCorrection			:=		0;
		//The file is offloaded into the readbuffer
		IF NOT(xReadWrite) OR NOT(dontLog) THEN 
			fileHandle			:=		SysFile.SysFileOpen(szFile:=sFilePath,am:=SysFile.ACCESS_MODE.AM_READ,pResult:=ADR(fileResultCode));
			IF fileHandle <> 0 AND TO_DWORD(fileHandle) <> 4294967295 AND fileResultCode = 0 THEN
				SysFile.SysFileSetPos(hFile:=fileHandle,ulOffset:=0);
				amountRead		:=		SysFile.SysFileRead(hFile:=fileHandle,pbyBuffer:=readBuffer,ulSize:=readSize,pResult:=ADR(fileResultCode));
				SysFile.SysFileClose(hFile:=fileHandle);
			END_IF
			reader.Initialize(buffer:=readBuffer,bufferSize:=readSize);
			doLogInt			:=		TRUE;
		ELSE
			fileFound			:=		FALSE;
		END_IF
		//When writing files the write buffer is initialized
		IF readWrite THEN
			writer.Initialize(buffer:=writeBuffer,bufferSize:=writeSize,singleLine:=FALSE,bottomType:=EStructType.object);
		END_IF
	END_IF
END_IF