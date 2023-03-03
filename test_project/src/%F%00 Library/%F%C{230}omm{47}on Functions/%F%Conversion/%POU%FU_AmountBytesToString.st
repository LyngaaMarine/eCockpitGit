{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function takes an amount of bytes and outputs as a nice readable string e.g
//100 = 100B
//1001 = 1.001kB
//17240034 = 17.24mB
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 27-07-19 | Creation
FUNCTION FU_AmountBytesToString : STRING(7)
VAR_INPUT
	amountBytes		:DWORD;
END_VAR
!__IMPLEMENTATION__!
IF amountBytes > 999999999 THEN
	FU_AmountBytesToString				:=		FU_sConcat(s1:=FU_sMid(sStr:=TO_STRING(TO_REAL(amountBytes/1000000)/1000),wLen:=5,wPos:=1),s2:='GB');
ELSIF amountBytes > 999999 THEN
	FU_AmountBytesToString				:=		FU_sConcat(s1:=FU_sMid(sStr:=TO_STRING(TO_REAL(amountBytes/1000)/1000),wLen:=5,wPos:=1),s2:='MB');
ELSIF amountBytes > 999 THEN
	FU_AmountBytesToString				:=		FU_sConcat(s1:=FU_sMid(sStr:=TO_STRING(TO_REAL(amountBytes)/1000),wLen:=5,wPos:=1),s2:='KB');
ELSE
	FU_AmountBytesToString				:=		FU_sConcat(s1:=TO_STRING(amountBytes),s2:='B');
END_IF