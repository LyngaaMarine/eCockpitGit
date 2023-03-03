{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates the difference in percent between iA and iB, on the scale iMax
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 11-12-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_diPerc_Diff : DINT
VAR_INPUT
	iA		:DINT;
	iB		:DINT;
	iMax	:DINT;
END_VAR
!__IMPLEMENTATION__!
IF iA > iB THEN
	FU_diPerc_Diff	:=		(iA - iB) * 100 / iMax;
ELSE
	FU_diPerc_Diff	:=		(iB - iA) * 100 / iMax;
END_IF