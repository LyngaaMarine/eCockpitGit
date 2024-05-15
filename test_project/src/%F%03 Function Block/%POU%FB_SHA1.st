{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This function calculates sha1 hashes
//First run reset to reset the function block
//Then run input to input the string
//Then run result or resultHex to output the finished hash
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
FUNCTION_BLOCK FB_SHA1
VAR
	hash		:ARRAY[0..4] OF DWORD;
	lenLow		:DWORD;
	lenHigh		:DWORD;
	block		:ARRAY[0..63] OF BYTE;
	index		:INT;
	computed	:BOOL;
	corrupted	:BOOL;
END_VAR

!__IMPLEMENTATION__!
