{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method is for inputting a stirng into the function block
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
METHOD input
VAR_INPUT
	str		:POINTER TO BYTE;
	len		:DWORD;
END_VAR

!__IMPLEMENTATION__!
WHILE len > 0 AND NOT(corrupted) DO
	len					:=		len - 1;
	block[index]		:=		str^ AND 16#FF;
	index				:=		index + 1;
	lenLow				:=		lenLow + 8;
	IF lenLow = 0 THEN
		lenHigh			:=		lenHigh + 1;
		IF lenHigh = 0 THEN
			corrupted	:=		TRUE;
		END_IF
	END_IF
	IF index = 64 THEN
		PMB();
	END_IF
	str					:=		str + 1;
END_WHILE