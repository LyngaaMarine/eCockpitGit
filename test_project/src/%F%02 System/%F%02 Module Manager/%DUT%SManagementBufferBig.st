{"external": false, "exclude_from_build": false}
TYPE SManagementBufferBig EXTENDS SManagementBufferBase :
STRUCT
	dataSize			:DWORD;					//Size of attached data
	data			:STRING(GConstants.moduleCommunicationBufferSize);	
END_STRUCT
END_TYPE
