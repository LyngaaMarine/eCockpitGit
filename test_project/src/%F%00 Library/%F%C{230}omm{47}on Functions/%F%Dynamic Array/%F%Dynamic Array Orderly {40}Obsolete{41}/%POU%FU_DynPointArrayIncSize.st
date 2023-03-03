{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This increases the size of a dynamic array of pointers
//Returns OutOfDynamicMemory when memory allocation fails
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-12-20 | Creation
FUNCTION FU_DynPointArrayIncSize:SLMResult
VAR_IN_OUT
	workingArray		:POINTER TO ARRAY[0..999] OF POINTER TO BYTE;	//Array
END_VAR
VAR_INPUT
	incrementAmount		:WORD;	//How much to increase the size of the array by at a time, keep this value the same all the time
END_VAR
VAR_OUTPUT
	arraySize			:WORD;	//Size of new array
END_VAR
VAR
	arrayBuffer			:POINTER TO ARRAY[0..999] OF POINTER TO BYTE;	//
	arrayDelete			:POINTER TO ARRAY[0..999] OF POINTER TO BYTE;	//Buffer for deallocating buffer memory
	arraySizeNew		:WORD;	//Size of new array
	i					:WORD;
END_VAR
!__IMPLEMENTATION__!
//Size of old memory is retrieved
arraySize								:=		TO_WORD(FU_getBlockSizeFromPointer(pData:=workingArray) / 4);
//If there is no space, the memory manager is queried for a new bigger buffer
arraySizeNew							:=		arraySize + incrementAmount;
arrayBuffer								:=		__NEW(POINTER TO BYTE,arraySizeNew);
//If the memory manager fails, the registerering fails
IF arrayBuffer = 0 THEN
	FU_DynPointArrayIncSize.code		:=		ERCodes.DynPointArrayIncSize;
	FU_DynPointArrayIncSize.reason		:=		GTErrors.EoutOfDynamicMemory;
	FU_DynPointArrayIncSize.success		:=		FALSE;
	RETURN;
END_IF
//The contens of the old buffer is copied to the new buffer
IF arraySize > 0 THEN
	FOR i := 0 TO arraySize - 1 DO
		arrayBuffer^[i]					:=		workingArray^[i];
	END_FOR
END_IF
//Old memory is stored for deletion
arrayDelete								:=		workingArray;
//Old buffer is overwritten with new buffer
workingArray							:=		arrayBuffer;
arraySize								:=		arraySize + incrementAmount;
//The old buffer is deregistered
FU_SafeDelete(pMem:=arrayDelete);