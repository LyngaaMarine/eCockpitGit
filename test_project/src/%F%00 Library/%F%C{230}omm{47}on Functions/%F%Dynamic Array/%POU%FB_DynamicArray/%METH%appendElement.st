{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Appends element to array
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD appendElement : SLMResult
VAR_INPUT
	element			:POINTER TO BYTE;	//Element to check
	elementSize		:WORD;		//Size of element
END_VAR
VAR_OUTPUT
	index			:WORD;
END_VAR

!__IMPLEMENTATION__!
IF S_lenght < S_maxSize THEN
	IF S_map THEN
		IF checkExists(element:=element,elementSize:=elementSize) THEN
			appendElement.success		:=		FALSE;
			appendElement.code			:=		ERCodes.FB_DynamicArray_addElement;
			appendElement.reason		:=		GTErrors.EelementInArray;
			RETURN;
		END_IF
	END_IF
	//If array is full, then more space is allocated
	IF S_lenght = S_blockSize THEN
		appendElement					:=		allocate(size:=S_blockSize + 1);
		IF NOT(appendElement.success) THEN
			RETURN;
		END_IF
	END_IF
	
	SysMem.SysMemCpy(pDest:=S_array^ + (S_lenght * S_elementSize),pSrc:=element,udiCount:=MIN(elementSize,S_elementSize));
	index										:=		S_lenght;
	S_lenght									:=		S_lenght + 1;
ELSE
	appendElement.success				:=		FALSE;
	appendElement.code					:=		ERCodes.FB_DynamicArray_addElement;
	appendElement.reason				:=		GTErrors.EarrayFull;
END_IF