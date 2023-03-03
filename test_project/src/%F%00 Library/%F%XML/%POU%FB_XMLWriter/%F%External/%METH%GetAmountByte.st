//This gets the amount of bytes which has been used in the buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD GetAmountByte : DWORD
VAR
	MethodID		:BYTE := 8;			//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
GetAmountByte		:=		FileBufferADR - FileBufferADROG;
//Last Method is recorded
LastMethod			:=		MethodID;