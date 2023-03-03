// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 25-04-18 | Creation
METHOD GetPositionInfo
VAR_OUTPUT
	pPos		:POINTER TO BYTE;	//The current address where the file is being written
	pMax		:POINTER TO BYTE;	//The address where the file buffer ends
	pStart		:POINTER TO BYTE;	//The address where the file buffer starts
END_VAR
(*%!%__DELIMITER__%!%*)
pPos		:=		FileBufferADR;
pMax		:=		FileBufferMaxADR;
pStart		:=		FileBufferADROG;