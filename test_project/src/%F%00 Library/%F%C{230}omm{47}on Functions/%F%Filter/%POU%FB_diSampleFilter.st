{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
FUNCTION_BLOCK FB_diSampleFilter
VAR_OUTPUT
	currentValue		:DINT;
	amountSamples		:BYTE;
END_VAR
VAR
	samples				:POINTER TO ARRAY[0..255] OF DINT;
	position			:BYTE;
END_VAR
!__IMPLEMENTATION__!
