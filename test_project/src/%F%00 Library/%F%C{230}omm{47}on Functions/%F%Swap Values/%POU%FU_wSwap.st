{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function swaps two values
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 13-06-18 | Updated to new guidelines                                                                                             |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_wSwap : BOOL
VAR_IN_OUT
	uiA		:WORD;		//Value a to be swapped with b
	uiB		:WORD;		//Value b to be swapped with a 
END_VAR
VAR
	C		:WORD;		//Holding variable
END_VAR
!__IMPLEMENTATION__!
C		:=		uiA;
uiA		:=		uiB;
uiB		:=		C;