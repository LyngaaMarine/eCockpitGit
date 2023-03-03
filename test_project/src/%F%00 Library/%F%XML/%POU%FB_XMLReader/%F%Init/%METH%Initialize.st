//This method initializes the manager with the correct values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 31-05-18 | Creation
METHOD Initialize : SLMResult
VAR_INPUT
	pBuffer			:POINTER TO BYTE;	//The address of the file buffer
	dwBufferSize	:DWORD;				//The size of the file buffer
END_VAR
(*%!%__DELIMITER__%!%*)
IF NOT(Initialized) THEN
	IF pBuffer <> 0 AND dwBufferSize <> 0 THEN
		FileBufferADROG		:=		pBuffer;				//Original adress is saved
		FileBufferMaxADR	:=		pBuffer + dwBufferSize;	//End adress is saved
		FileBufferSize		:=		dwBufferSize;					//Size of buffer is saved
		ADRCursor			:=		pBuffer;				//Cursor adress is updated
		DeclarationEnd		:=		ADRCursor;
	ELSE
		Initialize.success	:=		FALSE;
		Initialize.code		:=		ERCodes.FB_XMLReader_initialize;
		Initialize.reason	:=		GTErrors.EinvalidValue;
	END_IF
ELSE
	Initialize.success		:=		FALSE;
	Initialize.code			:=		ERCodes.FB_XMLReader_initialize;
	Initialize.reason		:=		GTErrors.EresourceInUse;
END_IF

