FUNCTION FU_ClearData : BOOL
VAR_INPUT
	data		:ANY;
END_VAR

(*%!%__DELIMITER__%!%*)
WHILE data.diSize > 0 DO
	data.pValue^		:=		0;
	data.pValue			:=		data.pValue + 1;
	data.diSize			:=		data.diSize - 1;
END_WHILE