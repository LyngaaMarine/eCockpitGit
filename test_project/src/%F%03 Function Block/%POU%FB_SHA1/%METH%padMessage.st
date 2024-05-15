{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
METHOD PROTECTED padMessage
!__IMPLEMENTATION__!
IF index > 55 THEN
	block[index]		:=		16#80;
	index				:=		index + 1;
	WHILE index < 64 DO
		block[index]	:=		0;
		index			:=		index + 1;
	END_WHILE
	pmb();
	WHILE index < 56 DO
		block[index]	:=		0;
		index			:=		index + 1;
	END_WHILE
ELSE
	block[index]		:=		16#80;
	index				:=		index + 1;
	WHILE index < 56 DO
		block[index]	:=		0;
		index			:=		index + 1;
	END_WHILE
END_IF
block[56]			:=		TO_BYTE(SHR(lenHigh,24));
block[57]			:=		TO_BYTE(SHR(lenHigh,16));
block[58]			:=		TO_BYTE(SHR(lenHigh,8));
block[59]			:=		TO_BYTE(lenHigh);
block[60]			:=		TO_BYTE(SHR(lenLow,24));
block[61]			:=		TO_BYTE(SHR(lenLow,16));
block[62]			:=		TO_BYTE(SHR(lenLow,8));
block[63]			:=		TO_BYTE(lenLow);
pmb();