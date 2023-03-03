//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Removes a given index from the array, by shifting all memory after it over it
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD removeElementByIndex : SLMResult
VAR_INPUT
	index			:WORD;		//Index to remove element from
END_VAR

(*%!%__DELIMITER__%!%*)
IF index < S_lenght THEN
	S_lenght							:=		S_lenght - 1;
	SysMem.SysMemCpy(pDest:=S_array + (index * 2),pSrc:=S_array + ((index + 1) * 2),udiCount:=(S_lenght - index) * 2);
	IF S_lenght = 0 THEN
		S_blockSize						:=		0;
		FU_SafeDelete(pMem:=S_array);
	END_IF
ELSE
	removeElementByIndex.success		:=		FALSE;
	removeElementByIndex.code			:=		ERCodes.FB_DynamicArray_removeElementByIndex;
	removeElementByIndex.reason			:=		GTErrors.EindexOutOfRange;
END_IF