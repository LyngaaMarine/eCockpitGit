//This function rounds the input down to the amount of decimals inputted on iN
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-03-19 | Creation
FUNCTION FU_rRound : REAL
VAR_INPUT
	X		:REAL;	//Value to be rounded	
	N		:BYTE;	//Amount of decimals
END_VAR
(*%!%__DELIMITER__%!%*)
FU_bMinMaxValue(Variable:= N, MinVal:= 0, MaxVal:= 8);
FU_rRound := DINT_TO_REAL(REAL_TO_DINT(X * GConstants.exponents[N])) / GConstants.exponents[N];