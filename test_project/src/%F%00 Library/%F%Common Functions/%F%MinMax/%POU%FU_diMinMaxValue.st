//This function keeps a variable between a minimum and a maximum value
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 07-01-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_diMinMaxValue : BOOL
VAR_IN_OUT
	Variable		:DINT;
END_VAR
VAR_INPUT
	MinVal			:DINT;
	MaxVal			:DINT;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Variable < MinVal THEN			//This makes sure only values between 0 and 10000 can be entered
	Variable				:=		MinVal;
ELSIF Variable > MaxVal THEN
	Variable				:=		MaxVal;
END_IF
