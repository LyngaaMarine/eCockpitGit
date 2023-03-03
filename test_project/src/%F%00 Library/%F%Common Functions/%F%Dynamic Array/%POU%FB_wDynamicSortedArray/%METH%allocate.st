//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Pre-allocates a given size to the array
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD allocate :SLMResult
VAR_INPUT
	size			:WORD;		//Size to allocate to array
END_VAR
VAR
	newArrayBuffer	:POINTER TO ARRAY[0..99] OF WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF size > S_blockSize THEN
	//Size is corrected to increment size
	size							:=		(((size - 1) / S_increment) + 1) * S_increment;
	//Byte size is calculated
	newArrayBuffer					:=		__NEW(WORD,size);
	//If the memory manager fails, the registerering fails
	IF newArrayBuffer = 0 THEN
		allocate.success			:=		FALSE;
		allocate.code				:=		ERCodes.FB_DynamicArray_allocateInternal;
		allocate.reason				:=		GTErrors.EoutOfDynamicMemory;
		RETURN;
	END_IF
	//The contens of the old buffer is copied to the new buffer
	IF S_lenght > 0 THEN
		SysMem.SysMemCpy(pDest:=newArrayBuffer,pSrc:=S_array,udiCount:=S_lenght * 2);
	END_IF
	//Old array memory is deleted, and new one is use
	FU_SafeDelete(pMem:=S_array);
	S_array							:=		newArrayBuffer;
	S_blockSize						:=		size;
END_IF