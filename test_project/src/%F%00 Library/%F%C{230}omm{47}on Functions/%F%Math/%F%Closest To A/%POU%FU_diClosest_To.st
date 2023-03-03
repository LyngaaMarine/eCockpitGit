{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates which value is closest to iCloseTo
//True = 1A, False = iB, if they are exactly the same amount away, the output is true
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 11-12-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_diClosest_To : BOOL
VAR_INPUT
	iA			:DINT;	//Value A
	iB			:DINT;	//Value B
	iCloseTo	:DINT;	//The value which A and B is checked against
END_VAR
VAR
	b1			:REAL;
	c1			:REAL;
END_VAR
!__IMPLEMENTATION__!
IF iCloseTo >= iA THEN
	IF iCloseTo >= iB THEN
		IF iA >= iB THEN
			FU_diClosest_To := TRUE;
		ELSE
			FU_diClosest_To := FALSE;
		END_IF
	ELSE
		b1 := TO_REAL(iCloseTo - iA);
		c1 := TO_REAL(iB - iCloseTo);
		IF b1 <= c1 THEN
			FU_diClosest_To := TRUE;
		ELSE
			FU_diClosest_To := FALSE;
		END_IF
		IF b1 = c1 THEN
			IF iA <= iB THEN
				FU_diClosest_To := TRUE;
			ELSE
				FU_diClosest_To := FALSE;
			END_IF
		END_IF
	END_IF
ELSE
	IF iCloseTo <= iB THEN
		IF iA <= iB THEN
			FU_diClosest_To := TRUE;
		ELSE
			FU_diClosest_To := FALSE;
		END_IF
	ELSE
		b1 := TO_REAL(iA - iCloseTo);
		c1 := TO_REAL(iCloseTo - iB);
		IF b1 <= c1 THEN
			FU_diClosest_To := TRUE;
		ELSE
			FU_diClosest_To := FALSE;
		END_IF
		IF b1 = c1 THEN
			IF iA <= iB THEN
				FU_diClosest_To := TRUE;
			ELSE
				FU_diClosest_To := FALSE;
			END_IF
		END_IF
	END_IF
END_IF