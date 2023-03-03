//This function, limits the amount of decimals after the decimal point, the decimal point is the english .
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sDecTruncBI : BOOL
VAR_IN_OUT
	str			:STRING(1);			//Input String
END_VAR
VAR_INPUT
	decimals	:WORD;				//How many decimals should be kept
END_VAR
VAR_INPUT
	pStr		:POINTER TO BYTE := ADR(str);	//Address of the string
END_VAR
(*%!%__DELIMITER__%!%*)
IF pStr <> 0 THEN
	WHILE pStr^ <> EASCII.Dot DO
		IF pStr^ = 0 THEN
			RETURN;
		END_IF
		pStr			:=		pStr + 1;
	END_WHILE
	IF decimals = 0 THEN
		pStr^			:=		0;
		RETURN;
	ELSE
		decimals		:=		decimals + 1;
		WHILE pStr^ <> 0 AND decimals > 0 DO
			pStr		:=		pStr + 1;
			decimals	:=		decimals - 1;
		END_WHILE
		pStr^			:=		0;
		RETURN;
	END_IF
END_IF
