{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method returns the result of the hash to a hexadecimal sting
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
METHOD resultHex :STRING(40)
VAR
	i			:BYTE;
	digest		:ARRAY[0..19] OF BYTE;
	hexbuffer	:BYTE;
END_VAR
VAR CONSTANT
	hexes		:ARRAY[0..15] OF BYTE := [48,49,50,51,52,53,54,55,56,57,97,98,99,100,101,102];
END_VAR
!__IMPLEMENTATION__!
result(output:=ADR(digest));
FOR i := 1 TO 20 DO
	hexbuffer			:=		SHR(digest[i-1],4);
	hexbuffer			:=		hexes[hexbuffer];
	resultHex[i*2-2]	:=		hexbuffer;
	hexbuffer			:=		digest[i-1] AND 15;
	hexbuffer			:=		hexes[hexbuffer];
	resultHex[i*2-1]	:=		hexbuffer;
END_FOR