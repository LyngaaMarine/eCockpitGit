{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
PROPERTY exponents_1 : ARRAY[0..8] OF REAL
!__GETTER__!
VAR
	i		:INT;
END_VAR
!__IMPLEMENTATION__!
FOR i := 0 TO 8 DO
	exponents_1[i] := exponents[i];
END_FOR
!__SETTER__!
VAR
	y		:INT;
END_VAR
!__IMPLEMENTATION__!
FOR y := 0 TO 8 DO
	exponents[y] := exponents_1[y];
END_FOR