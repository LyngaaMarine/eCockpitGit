{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates The average of the two inputs
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 20-09-18 | Updated to new format                                                                                                 |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_iAverageOfTwo : INT
VAR_INPUT
	iA			:INT;	//Value A
	iB			:INT;	//Value B
END_VAR
!__IMPLEMENTATION__!
FU_iAverageOfTwo := (iA+iB)/2;