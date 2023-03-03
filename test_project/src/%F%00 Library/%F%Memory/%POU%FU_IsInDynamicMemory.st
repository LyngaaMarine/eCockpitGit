//This function checks if the given memory is within the dynamic space
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 24-05-22 | Creation
FUNCTION FU_IsInDynamicMemory : BOOL
VAR_IN_OUT
	pMem		:POINTER TO BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
FU_IsInDynamicMemory		:=		GMemory.dynamicStart > 0 AND TO_DWORD(pMem) >= GMemory.dynamicStart AND TO_DWORD(pMem) < GMemory.dynamicStart + GMemory.dynamicSize;