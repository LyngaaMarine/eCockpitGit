{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Handler for managing sorted dynamic array of words
//Sorted arrays are much faster when checking for elements in array
//FB_wDynamicSortedArray(pArray:=dynArray,wIncrement:=16,wElementSize:=SIZEOF(WORD),wMaxSize:=0,xStringArray:=FALSE,xMap:=FALSE)
FUNCTION_BLOCK FB_wDynamicSortedArray
VAR_OUTPUT
	S_lenght			:WORD;		//Amount of elements in array
END_VAR
VAR
	S_array				:POINTER TO ARRAY[0..99] OF WORD;	//Pointer to array pointer 
	S_increment			:WORD := 1;	//How many element sizes are allocated when array size is increased
	S_maxSize			:WORD;		//Max size allowed for array, 0 means no max
	S_map				:BOOL;		//Set true for mapped mode, where duplicate elements cannot 
	S_blockSize			:WORD;		//Size of allocated memory
END_VAR
!__IMPLEMENTATION__!
