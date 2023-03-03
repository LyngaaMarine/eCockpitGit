{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates the difference in percent between iA and iB, on the scale iMax
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 10-01-18 | Updated to new format                                                                                                 |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_iPerc_Diff : INT
VAR_INPUT
	iA		:INT;
	iB		:INT;
	iMax	:INT;
END_VAR
!__IMPLEMENTATION__!
IF iA > iB THEN
	FU_iPerc_Diff	:=		(iA - iB) * 100 / iMax;
ELSE
	FU_iPerc_Diff	:=		(iB - iA) * 100 / iMax;
END_IF