//Handler for managing dynamic arrays of any type
//FB_DynamicArray(pArray:=dynArray,wIncrement:=16,wElementSize:=SIZEOF(WORD),wMaxSize:=0,xStringArray:=FALSE,xMap:=FALSE)
FUNCTION_BLOCK FB_DynamicArray
VAR_OUTPUT
	S_lenght			:WORD;		//Amount of elements in array
END_VAR
VAR
	S_array				:POINTER TO POINTER TO ARRAY[0..99] OF BYTE;	//Pointer to array pointer 
	S_increment			:WORD := 1;	//How many element sizes are allocated when array size is increased
	S_elementSize		:WORD;		//Size of individual element in array
	S_maxSize			:WORD;		//Max size allowed for array, 0 means no max
	S_strings			:BOOL;		//Set true if the array contains only strings, as they should be compared with zero termination
	S_map				:BOOL;		//Set true for mapped mode, where duplicate elements cannot 
	S_blockSize			:WORD;		//Size of allocated memory
END_VAR
(*%!%__DELIMITER__%!%*)
