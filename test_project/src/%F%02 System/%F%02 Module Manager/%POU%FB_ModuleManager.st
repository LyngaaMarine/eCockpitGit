{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function blocks acts as a group for the browser, it has no other function
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 07-07-20 | Creation
FUNCTION_BLOCK FB_ModuleManager EXTENDS FB_Module
VAR_OUTPUT
	S_currentTimeDT				:DT;					//The current system time in ms
	S_currentTimeDWORD			:DWORD;					//The current system time in dword format
	S_currentTime				:POINTER TO ATimeShow := ADR(S_currentTimeInt) + 3;	//The system time as string eg. 2019-9-3-10:22:32
	S_upTime					:DWORD;					//The amount of time the system has been up in seconds
	
	S_initialized				:BOOL;
	S_highestUID				:AModuleUID;
END_VAR
VAR
	S_bootTime					:DWORD;					//The time the system booted
	S_currentTimeInt			:STRING(22);	//The system time in

	//Module Registry
	S_modules					:ARRAY[1..GParameters.maxModules] OF POINTER TO FB_Module;
	S_modulesInOrder			:ARRAY[1..GParameters.maxModules + 1] OF POINTER TO FB_Module;		//Dynamic array of all modules in the system
	S_modulesAmount				:AModuleUID; 			//Actual amount is one less
	S_moduleUpdate				:WORD := 1;				//This is incremented every time there is an module update
		
	S_moduleInitialization		:INT;
	S_moduleInitProgress		:AModuleUID := 1;
	S_missingUID				:AModuleUID;
	S_loadDone					:BOOL;
	S_subModulesBuffer			:ARRAY[1..GConstants.maxSubModules] OF POINTER TO FB_Module;		//Buffer of all sub modules for the currently loading module
	S_subModulesBufferAmount	:AModuleSID;
	S_subModulesInvalidBuffer	:ARRAY[1..GConstants.maxSubModules] OF POINTER TO FB_Module;		//Buffer of all sub modules with invalid sub ids
	S_subModulesInvalidAmount	:AModuleSID;
	S_failedModule				:POINTER TO FB_Module;	//If boot fails, then this modulee was the one to fail
	S_failedModuleType			:AModuleDes;			//If boot fails then this module designator was the one to fail
	S_failedResult				:SLMResult;				//If boot fails then this module designator was the one to fail

	//Management event buffers
	S_threadSafeActive			:BOOL;
	S_noDataBuffer				:ARRAY[0..S_noMessageBufferSize - 1] OF SManagementBufferBase;
	S_noDataFIFO				:FB_FIFOArray := (S_bufferSize:=SIZEOF(S_noDataBuffer)/SIZEOF(S_noDataBuffer[0]));
	S_dataBuffer				:ARRAY[0..S_bigMessageBufferSize - 1] OF SManagementBufferBig;
	S_dataFIFO					:FB_FIFOArray := (S_bufferSize:=SIZEOF(S_dataBuffer)/SIZEOF(S_dataBuffer[0]));

	//Buffer for orders to save modules
	S_saveModuleBuffer			:ARRAY[0..S_saveBufferSize - 1] OF SModuleSaveBuffer;
	S_saveModuleFIFO			:FB_FIFOArray := (S_bufferSize:=SIZEOF(S_saveModuleBuffer)/SIZEOF(S_saveModuleBuffer[0]));
	S_loadBuffer				:ALoadSaveBuffer;
	S_saveBuffer				:ALoadSaveBuffer;
	S_loadSaver					:FB_LoadSave := (module:=THIS,readBuffer:=ADR(S_loadBuffer),readSize:=SIZEOF(S_loadBuffer),writeBuffer:=ADR(S_saveBuffer),writeSize:=SIZEOF(S_saveBuffer));	//For loading and saving modules
END_VAR
VAR CONSTANT
	S_maxSaveQueue				:WORD := 1000;	//Maximum amount of spaces in save queue
	S_maxDeleteQueue			:WORD := 1000;	//Maximum amount of spaces in delete queue
	S_maxupdateClientQueue		:WORD := 1000;	//Maximum amount of spaces in update queue	
	S_dataInitBuffSize			:BYTE := 50;	//Maximum amount of data reserved for data initializers
	S_noMessageBufferSize		:WORD := 1000;
	S_bigMessageBufferSize		:BYTE := 4;
	S_updateBufferSize			:BYTE := 100;
	S_saveBufferSize			:BYTE := 100;
END_VAR
!__IMPLEMENTATION__!
