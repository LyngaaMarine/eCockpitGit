//This initializes the manager with the correct values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD Initialize : SLMResult
VAR_INPUT
	pBuffer			:POINTER TO BYTE;	//The address of the file buffer
	dwBufferSize	:DWORD;				//The size of the file buffer
END_VAR
VAR
	MethodID		:BYTE := 1;			//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
//Buffer ADR is recorded
IF NOT(Initialized) THEN
	IF pBuffer <> 0 AND dwBufferSize <> 0 THEN
		FileBufferADR		:=		pBuffer;
		FileBufferADROG		:=		pBuffer;
		FileBufferMaxADR	:=		FileBufferADR + dwBufferSize;
		//Initialisation is done
		Initialized			:=		TRUE;
		//Last Method is recorded
		LastMethod			:=		MethodID;
	ELSE
		Initialize.success	:=		FALSE;
		Initialize.code		:=		ERCodes.FB_XMLWriter_initialize;
		Initialize.reason	:=		GTErrors.EinvalidValue;
	END_IF
ELSE
	Initialize.success		:=		FALSE;
	Initialize.code			:=		ERCodes.FB_XMLWriter_initialize;
	Initialize.reason		:=		GTErrors.EresourceInUse;
END_IF