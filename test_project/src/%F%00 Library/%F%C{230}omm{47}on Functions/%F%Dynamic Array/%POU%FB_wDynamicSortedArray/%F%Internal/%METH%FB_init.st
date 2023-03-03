{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Reinitialization is not supported, so only set values once;
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD FB_Init: BOOL
VAR_INPUT
    bInitRetains		:BOOL; 		//TRUE: the retain variables are initialized (reset warm / reset cold)
    bInCopyCode			:BOOL;  	//TRUE: the instance will be copied to the copy code afterward (online change)
	wIncrement			:WORD;		//How many element sizes are allocated when array size is increased
	wMaxSize			:WORD;		//Max size allowed for array, 0 means no max
	xMap				:BOOL;		//Set true for mapped mode, where duplicate elements cannot 
END_VAR
!__IMPLEMENTATION__!
IF S_array = 0 THEN
	S_increment			:=		wIncrement;
	IF wMaxSize = 0 THEN
		S_maxSize		:=		65535;
	ELSE
		S_maxSize		:=		wMaxSize;
	END_IF
	S_map				:=		xMap;
END_IF