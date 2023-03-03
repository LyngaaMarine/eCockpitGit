{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function deletes all the none number characters from the string, until it finds zero
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-06-18 | Creation
FUNCTION FU_OnlyNumbersBI 
VAR_INPUT
	str			:STRING(1);			//String
END_VAR
VAR
	pStr		:POINTER TO BYTE := ADR(str);	//Address of source string
	StrBuff		:POINTER TO BYTE;	//Buffer for Address of the string
END_VAR
!__IMPLEMENTATION__!
IF pStr <> 0 THEN
	//Buffers are updated
	StrBuff					:=		pStr;
	//It runs until string ends
	WHILE pStr^ <> 0 DO
		//If a non number character is found, the next number character is then found
		WHILE StrBuff^ < EASCII.Zero OR StrBuff^ > EASCII.Nine DO
			//If no number is found before string end, it finishes
			IF StrBuff^ = 0 THEN
				pStr^		:=		0;
				RETURN;
			END_IF
			StrBuff			:=		StrBuff + 1;
		END_WHILE
		//Found number is copied
		pStr^				:=		StrBuff^;
		//Next character
		pStr				:=		pStr + 1;
		StrBuff				:=		StrBuff + 1;
	END_WHILE
END_IF