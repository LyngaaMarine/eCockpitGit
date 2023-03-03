{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function makes sure that memory to delete is within dynamic area
//It cannot check if the given pointer is valid
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 24-05-22 | Creation
FUNCTION FU_SafeDelete : BOOL
VAR_IN_OUT
	pMem		:POINTER TO BYTE;
END_VAR
!__IMPLEMENTATION__!
IF GMemory.dynamicStart > 0 AND TO_DWORD(pMem) >= GMemory.dynamicStart AND TO_DWORD(pMem) < GMemory.dynamicStart + GMemory.dynamicSize THEN
	__DELETE(pMem);
ELSE
	pMem			:=		0;
END_IF