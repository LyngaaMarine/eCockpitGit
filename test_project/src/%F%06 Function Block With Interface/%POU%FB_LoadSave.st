{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This function block takes care of reading and writing from/to files
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-09-20 | Creation
FUNCTION_BLOCK FB_LoadSave IMPLEMENTS ITF_StructWriterBase,ITF_StructReaderBase
VAR_INPUT
	dontLog					:BOOL;
	readBuffer				:POINTER TO BYTE;	//Buffer for reading
	readSize				:DWORD;				//Buffer size for reading
	writeBuffer				:POINTER TO BYTE;	//Buffer for writing
	writeSize				:DWORD;				//Buffer size for writing
END_VAR
VAR
	filePath				:APath;				//Path to save file
	logCorrection			:WORD;				//This makes sure the logging doesn't get out of sync when the written files are 
	started					:BOOL;
	readWrite				:BOOL;
	doLogInt				:BOOL;				//Wether 
	keyFound				:BOOL;				//If the autologger found the written key
	reader					:FB_JSONReader;
	writer					:FB_JSONWriter;
END_VAR
!__IMPLEMENTATION__!
