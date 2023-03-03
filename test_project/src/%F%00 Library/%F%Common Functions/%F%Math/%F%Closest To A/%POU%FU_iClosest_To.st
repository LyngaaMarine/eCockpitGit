//This function calculates which value is closest to iCloseTo
//True = 1A, False = iB, if they are exactly the same amount away, the output is true
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 20-09-18 | Updated to new format                                                                                                 |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_iClosest_To : BOOL
VAR_INPUT
	iA			:INT;	//Value A
	iB			:INT;	//Value B
	iCloseTo	:INT;	//The value which A and B is checked against
END_VAR
VAR
	b1			:REAL;
	c1			:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF iCloseTo >= iA THEN
	IF iCloseTo >= iB THEN
		IF iA >= iB THEN
			FU_iClosest_To := TRUE;
		ELSE
			FU_iClosest_To := FALSE;
		END_IF
	ELSE
		b1 := iCloseTo - iA;
		c1 := iB - iCloseTo;
		IF b1 <= c1 THEN
			FU_iClosest_To := TRUE;
		ELSE
			FU_iClosest_To := FALSE;
		END_IF
		IF b1 = c1 THEN
			IF iA <= iB THEN
				FU_iClosest_To := TRUE;
			ELSE
				FU_iClosest_To := FALSE;
			END_IF
		END_IF
	END_IF
ELSE
	IF iCloseTo <= iB THEN
		IF iA <= iB THEN
			FU_iClosest_To := TRUE;
		ELSE
			FU_iClosest_To := FALSE;
		END_IF
	ELSE
		b1 := iA - iCloseTo;
		c1 := iCloseTo - iB;
		IF b1 <= c1 THEN
			FU_iClosest_To := TRUE;
		ELSE
			FU_iClosest_To := FALSE;
		END_IF
		IF b1 = c1 THEN
			IF iA <= iB THEN
				FU_iClosest_To := TRUE;
			ELSE
				FU_iClosest_To := FALSE;
			END_IF
		END_IF
	END_IF
END_IF