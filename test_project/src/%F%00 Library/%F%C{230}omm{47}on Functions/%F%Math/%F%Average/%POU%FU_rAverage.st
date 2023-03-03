{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This calculates the average of a stream of numbers
//Must be used like this average := FU_iAvarage(lastAverage:=average,newValue:=value,count:=count);
//Count starts at 1
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 12-01-21 | creation
FUNCTION FU_rAverage : REAL
VAR_INPUT
	lastAverage		:REAL;
	newValue		:REAL;
	count			:BYTE;
END_VAR
!__IMPLEMENTATION__!
FU_rAverage := (lastAverage +  (newValue - lastAverage) / count + 1) - 1;