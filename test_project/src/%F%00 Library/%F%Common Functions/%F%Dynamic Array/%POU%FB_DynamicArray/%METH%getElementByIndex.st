//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Copies data from index in array to given memory position
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-03-22 | Creation
METHOD getElementByIndex : SLMResult
VAR_INPUT
	element			:POINTER TO BYTE;
	elementSize		:WORD;
	index			:WORD;
END_VAR

(*%!%__DELIMITER__%!%*)
IF index < S_lenght THEN
	SysMem.SysMemCpy(pDest:=element,pSrc:=S_array^ + (index * S_elementSize),udiCount:=MIN(S_elementSize,elementSize));
ELSE
	getElementByIndex.success		:=		FALSE;
	getElementByIndex.code			:=		ERCodes.FB_DynamicArray_removeElementByIndex;
	getElementByIndex.reason		:=		GTErrors.EindexOutOfRange;
END_IF