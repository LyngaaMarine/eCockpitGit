{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method returns the result of the hash calculation in bytes
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
METHOD result
VAR_INPUT
	output		:POINTER TO ARRAY[0..19] OF BYTE;	//Array of at least 20 bytes
END_VAR
VAR
	i			:UINT;
END_VAR
!__IMPLEMENTATION__!
IF corrupted THEN
	RETURN;
END_IF
IF NOT(computed) THEN
	padMessage();
	FOR i := 0 TO 63 DO
		block[i]	:=		0;
	END_FOR
	lenLow			:=		0;
	lenHigh			:=		0;
	computed		:=		TRUE;
END_IF
FOR i := 0 TO 19 DO
	output^[i]		:=		TO_BYTE(SHR(hash[SHR(i,2)],8 * (3 - (i AND 16#03))));
END_FOR