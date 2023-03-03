{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This checks if a pointer is inside a dynamic pointer array
//Returns true if a duplicate is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-12-20 | Creation
FUNCTION FU_DynPointArrayOrderCheckDupe:BOOL
VAR_IN_OUT
	arrayAmount			:WORD;	//Amount in array
	workingArray		:POINTER TO ARRAY[0..999] OF POINTER TO BYTE;	//Array
END_VAR
VAR_INPUT
	checkPoint			:POINTER TO BYTE;	//The pointer to remove from the array
END_VAR
VAR
	i					:WORD;
END_VAR
!__IMPLEMENTATION__!
//Check for valid pointer
IF checkPoint = 0 THEN
	RETURN;
END_IF
IF arrayAmount > 0 THEN
	FOR i := 0 TO arrayAmount - 1 DO
		IF checkPoint = workingArray^[i] THEN
			FU_DynPointArrayOrderCheckDupe	:=		TRUE;
			RETURN;
		END_IF
	END_FOR
END_IF