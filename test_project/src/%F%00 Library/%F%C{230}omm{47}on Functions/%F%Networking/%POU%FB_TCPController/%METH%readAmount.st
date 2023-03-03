{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Called after data is read from read buffer, with amount read
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD readAmount : BOOL
VAR_INPUT
	amount			:DINT;
END_VAR
VAR
	i				:DINT;
END_VAR
!__IMPLEMENTATION__!
IF amount < S_recieveAmount THEN
	FOR i := 0 TO S_recieveAmount - amount - 1 DO
		S_recieveBuffer^[i]		:=		S_recieveBuffer^[i + amount];
	END_FOR
	S_recieveAmount				:=		S_recieveAmount - amount;	
ELSE
	S_recieveAmount				:=		0;	
END_IF
