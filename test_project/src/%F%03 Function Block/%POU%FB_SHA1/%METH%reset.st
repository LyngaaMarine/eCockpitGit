{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method resets the function block
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
METHOD reset
!__IMPLEMENTATION__!
lenLow		:=		0;
lenHigh		:=		0;
index		:=		0;
computed	:=		0;
corrupted	:=		0;
hash[0]		:=			16#67452301;
hash[1]		:=		16#EFCDAB89;
hash[2]		:=		16#98BADCFE;
hash[3]		:=		16#10325476;
hash[4]		:=		16#C3D2E1F0;
