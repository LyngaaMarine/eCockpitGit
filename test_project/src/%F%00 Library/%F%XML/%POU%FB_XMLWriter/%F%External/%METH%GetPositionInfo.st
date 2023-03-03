{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 25-04-18 | Creation
METHOD GetPositionInfo
VAR_OUTPUT
	pPos		:POINTER TO BYTE;	//The current address where the file is being written
	pMax		:POINTER TO BYTE;	//The address where the file buffer ends
	pStart		:POINTER TO BYTE;	//The address where the file buffer starts
END_VAR
!__IMPLEMENTATION__!
pPos		:=		FileBufferADR;
pMax		:=		FileBufferMaxADR;
pStart		:=		FileBufferADROG;