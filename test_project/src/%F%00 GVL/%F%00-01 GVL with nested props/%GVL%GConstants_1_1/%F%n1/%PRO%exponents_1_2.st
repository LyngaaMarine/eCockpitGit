{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
PROPERTY exponents_1_2 : ARRAY[0..8] OF REAL
!__GETTER__!
VAR
	i		:INT;
	exponents2	:ARRAY[0..8] OF REAL;
END_VAR
!__IMPLEMENTATION__!
exponents2		:=		exponents_1_1;
FOR i := 0 TO 8 DO
	exponents_1_2[i] := exponents2[i];
END_FOR
!__SETTER__!
VAR
	y		:INT;
END_VAR
!__IMPLEMENTATION__!
FOR y := 0 TO 8 DO
	exponents[y] := exponents_1[y];
END_FOR
exponents_1_1 := exponents;