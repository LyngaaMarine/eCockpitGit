{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This adds a pointer to a dynamic pointer array, if the array is full it increments the size of the array
//It is orderly meaning that all the stored ids are one after the other
//This ensures that a process can loop through all entries without checking for null pointers and only until the array amount value is reached
//Returns OutOfDynamicMemory when memory allocation fails
//Returns AlreadyInRegistry if pointer is already in array
//Returns VarsWrong if invalid pointer is given
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-12-20 | Creation
FUNCTION FU_DynPointArrayOrderAdd:SLMResult
VAR_IN_OUT
	arrayAmount			:WORD;	//Amount in array
	workingArray		:POINTER TO ARRAY[0..999] OF POINTER TO BYTE;	//Array
END_VAR
VAR_INPUT
	addPoint			:POINTER TO BYTE;	//The pointer to add
	incrementAmount		:WORD;	//How much to increase the size of the array by at a time, keep this value the same all the time
END_VAR
VAR
	arraySize			:DWORD;
END_VAR
!__IMPLEMENTATION__!
//Check for valid pointer
IF addPoint = 0 THEN
	FU_DynPointArrayOrderAdd.code		:=		ERCodes.DynPointArrayOrderAdd;
	FU_DynPointArrayOrderAdd.reason		:=		GTErrors.EinvalidPointer;
	FU_DynPointArrayOrderAdd.success	:=		FALSE;
	RETURN;
END_IF
//Checks if pointer is already in array
IF FU_DynPointArrayOrderCheckDupe(arrayAmount:=arrayAmount,workingArray:=workingArray,checkPoint:=addPoint) THEN
	FU_DynPointArrayOrderAdd.code		:=		ERCodes.DynPointArrayOrderAdd;
	FU_DynPointArrayOrderAdd.reason		:=		GTErrors.EpointerAlreadyRegistered;
	FU_DynPointArrayOrderAdd.success	:=		FALSE;
	RETURN;
END_IF
//Size of memory is retrived
arraySize						:=		FU_getBlockSizeFromPointer(pData:=workingArray) / 4;

//This checks if there is space left in the managers buffer
IF arrayAmount = arraySize THEN
	FU_DynPointArrayOrderAdd	:=		FU_DynPointArrayIncSize(workingArray:=workingArray,incrementAmount:=incrementAmount);
	IF NOT(FU_DynPointArrayOrderAdd.success) THEN
		RETURN;
	END_IF
END_IF
workingArray^[arrayAmount]		:=		addPoint;
arrayAmount						:=		arrayAmount + 1;