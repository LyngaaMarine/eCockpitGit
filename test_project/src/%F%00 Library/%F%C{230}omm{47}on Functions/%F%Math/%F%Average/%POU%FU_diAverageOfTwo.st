{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates The average of the two inputs
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 11-12-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_diAverageOfTwo : DINT
VAR_INPUT
	iA			:DINT;	//Value A
	iB			:DINT;	//Value B
END_VAR
!__IMPLEMENTATION__!
FU_diAverageOfTwo := (iA+iB)/2;
