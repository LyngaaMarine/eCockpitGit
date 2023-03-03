TYPE SModManDataClientData :
STRUCT
	dataInitProgress		:WORD;		
	dataInitRuns			:WORD;		
	dataInitBuffer			:ARRAY[0..FB_ModuleManager.S_dataInitBuffSize - 1] OF BYTE;	//Buffer for data initialization
	moduleSyncProgress		:WORD;		
END_STRUCT
END_TYPE
