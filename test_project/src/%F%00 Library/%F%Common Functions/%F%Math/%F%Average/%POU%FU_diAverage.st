//This calculates the average of a stream of numbers
//Must be used like this average := FU_iAvarage(lastAverage:=average,newValue:=value,count:=count);
//Count starts at 1
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 12-01-21 | creation
FUNCTION FU_diAverage : DINT
VAR_INPUT
	lastAverage		:DINT;
	newValue		:DINT;
	count			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
FU_diAverage := (lastAverage +  (newValue - lastAverage) / count + 1) - 1;