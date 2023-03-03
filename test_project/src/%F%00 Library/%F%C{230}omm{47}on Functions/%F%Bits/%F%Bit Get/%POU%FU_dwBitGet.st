{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function get the bit value from a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-01-19 | Creation
FUNCTION FU_dwBitGet : BOOL
VAR_INPUT
	dbVar	:DWORD;		//The value to work with
	bIndex	:BYTE;		//Which bit to get	
END_VAR
!__IMPLEMENTATION__!
FU_dwBitGet		:=		(dbVar AND SHL(1,bIndex)) <> 0;