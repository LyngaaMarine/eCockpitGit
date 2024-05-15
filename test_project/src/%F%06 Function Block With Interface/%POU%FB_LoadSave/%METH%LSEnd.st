{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method ends the manager, by deinitialisint XML blocks and writing to file if needed
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 26-06-18 | Creation
// | 2         | NSN      | 31-01-19 | Updated to new standard
METHOD LSEnd
VAR
	fileResultCode			:SysTypes.RTS_IEC_RESULT;
	fileHandle				:SysTypes.RTS_IEC_HANDLE;
	sizeBuffer				:DWORD;
END_VAR
!__IMPLEMENTATION__!
IF started THEN
	IF readWrite THEN
		writer.deinitialize();
		fileHandle		:=		SysFile.SysFileOpen(szFile:=filePath,am:=SysFile.ACCESS_MODE.AM_APPEND_PLUS,pResult:=ADR(fileResultCode));
		IF fileHandle <> 0 AND fileResultCode = 0 THEN
			SysFile.SysFileSetPos(hFile:=fileHandle,ulOffset:=0);
			sizeBuffer	:=		writer.bufferSize;
			SysFile.SysFileWrite(hFile:=fileHandle,pbyBuffer:=writeBuffer,ulSize:=sizeBuffer,pResult:=ADR(fileResultCode));
			SysFile.SysFileTruncate(hFile:=fileHandle,ulSizeNew:=sizeBuffer);
			SysFile.SysFileClose(hFile:=fileHandle);
		END_IF
	END_IF	
	reader.deinitialize();
	filePath			:=		'';
	readWrite			:=		FALSE;
	started				:=		FALSE;
END_IF
