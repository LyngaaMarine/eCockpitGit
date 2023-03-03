METHOD addSample
VAR_INPUT
	sample		:DINT;
END_VAR
VAR	
	i			:BYTE;
	sumBuffer	:LINT;
END_VAR
(*%!%__DELIMITER__%!%*)
IF samples <> 0 THEN
	samples^[position]		:=		sample;
	position				:=		position + 1;
	IF position >= amountSamples THEN
		position			:=		0;
	END_IF
	FOR i := 0 TO amountSamples - 1 DO
		sumBuffer			:=		sumBuffer + samples^[i];
	END_FOR
	currentValue			:=		TO_DINT(sumBuffer / amountSamples);
END_IF