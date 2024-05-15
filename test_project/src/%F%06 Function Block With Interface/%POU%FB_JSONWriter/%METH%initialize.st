{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This initializes the manager with the correct values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD initialize : SLMResult
VAR_INPUT
	buffer			:POINTER TO BYTE;	//The address of the file buffer
	bufferSize		:DWORD;				//The size of the file buffer
	singleLine		:BOOL;
	bottomType		:EStructType;
END_VAR
!__IMPLEMENTATION__!
//Buffer ADR is recorded
IF NOT(ready) THEN
	IF buffer <> 0 AND bufferSize <> 0 THEN
		bufferPosition		:=		buffer;
		bufferAddress		:=		buffer;
		bufferMaxADR		:=		bufferPosition + bufferSize;
		useSingleLine		:=		singleLine;
		bufferInvalid		:=		FALSE;
		//Initialisation is done
		ready				:=		TRUE;
		//First curly bracket is added
		bottomTypeInt		:=		bottomType;
		CASE bottomType OF
			EStructType.object:
				afterKey	:=		TRUE;
				objectStart(singleLine:=FALSE);
			EStructType.tArray:
				afterKey	:=		TRUE;
				arrayStart(singleLine:=FALSE);
		ELSE
			singleVal		:=		TRUE;
		END_CASE
	ELSE
		initialize.success	:=		FALSE;
		initialize.code		:=		ERCodes.FB_JSONWriter_initialize;
		initialize.reason	:=		GTErrors.EmissingInputVars;
	END_IF
ELSE
	initialize.success		:=		FALSE;
	initialize.code			:=		ERCodes.FB_JSONWriter_initialize;
	initialize.reason		:=		GTErrors.EresourceInUse;
END_IF