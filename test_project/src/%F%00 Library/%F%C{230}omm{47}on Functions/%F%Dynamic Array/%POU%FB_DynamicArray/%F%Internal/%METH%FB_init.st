{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Reinitialization is not supported, so only set values once;
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD FB_Init: BOOL
VAR_INPUT
    bInitRetains		:BOOL; 		//TRUE: the retain variables are initialized (reset warm / reset cold)
    bInCopyCode			:BOOL;  	//TRUE: the instance will be copied to the copy code afterward (online change)
	pArray				:REFERENCE TO POINTER TO ARRAY[0..99] OF BYTE;	//Pointer to array pointer
	wIncrement			:WORD;		//How many element sizes are allocated when array size is increased
	wElementSize		:WORD;		//Size of individual element in array
	wMaxSize			:WORD;		//Max size allowed for array, 0 means no max
	xStringArray		:BOOL;		//Set true if the array contains only strings, as they should be compared with zero termination
	xMap				:BOOL;		//Set true for mapped mode, where duplicate elements cannot 
END_VAR
!__IMPLEMENTATION__!
IF S_array = 0 THEN
	S_array				:=		ADR(pArray);
	S_increment			:=		wIncrement;
	S_elementSize		:=		wElementSize;
	IF wMaxSize = 0 THEN
		S_maxSize		:=		65535;
	ELSE
		S_maxSize		:=		wMaxSize;
	END_IF
	S_strings			:=		xStringArray;
	S_map				:=		xMap;
END_IF