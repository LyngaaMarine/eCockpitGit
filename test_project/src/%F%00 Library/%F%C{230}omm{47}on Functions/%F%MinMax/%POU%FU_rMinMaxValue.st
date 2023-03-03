{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function keeps a variable between a minimum and a maximum value
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 07-01-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rMinMaxValue : BOOL
VAR_IN_OUT
	Variable		:REAL;
END_VAR
VAR_INPUT
	MinVal			:REAL;
	MaxVal			:REAL;
END_VAR
!__IMPLEMENTATION__!
IF Variable < MinVal THEN			//This makes sure only values between minval and maxval can be entered
	Variable				:=		MinVal;
ELSIF Variable > MaxVal THEN
	Variable				:=		MaxVal;
END_IF
