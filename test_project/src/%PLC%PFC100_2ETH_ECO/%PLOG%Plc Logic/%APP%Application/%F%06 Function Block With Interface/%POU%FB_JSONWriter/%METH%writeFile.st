{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method writes the buffer to a file
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-05-21 | Creation
METHOD writeFile
VAR_INPUT
	path			:APath;	//Path of directory to copy from
END_VAR
VAR
	fileResult		:RTS_IEC_RESULT;
	fileHandle		:SysTypes.RTS_IEC_HANDLE;
	lengthBuff		:DWORD;
END_VAR
!__IMPLEMENTATION__!
fileHandle				:=		SysFile.SysFileOpen(szFile:=path,am:=SysFile.ACCESS_MODE.AM_APPEND_PLUS,pResult:=ADR(fileResult));
IF fileHandle <> 0 AND TO_DWORD(fileHandle) <> 16#FFFFFFFF THEN
	SysFile.SysFileSetPos(hFile:=fileHandle,ulOffset:=0);
	lengthBuff			:=		bufferSize;
	SysFile.SysFileWrite(hFile:=fileHandle,pbyBuffer:=bufferAddress,ulSize:=lengthBuff,pResult:=ADR(fileResult));
	SysFile.SysFileTruncate(hFile:=fileHandle,ulSizeNew:=lengthBuff);
	SysFile.SysFileClose(hFile:=fileHandle);
END_IF