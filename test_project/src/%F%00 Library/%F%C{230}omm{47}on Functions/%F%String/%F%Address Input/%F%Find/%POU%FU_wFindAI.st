{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function find a string in another string, and returns the position of the found string.
//It returns 0 if nothing is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
FUNCTION FU_wFindAI : WORD
VAR_INPUT
	s1			:POINTER TO EASCII;		//Input String1
	s2			:POINTER TO EASCII;		//Input String2
END_VAR
VAR
	Str1Buff	:POINTER TO BYTE;		//Buffer address for string1
	Str2Buff	:POINTER TO BYTE;		//Buffer address for string2
	ResultBuff	:WORD;
END_VAR
!__IMPLEMENTATION__!
Str2Buff	 :=		s2;
WHILE s1^ <> 0 DO
	IF s1^ = s2^ THEN
		Str1Buff			:=		s1 + 1;
		s2					:=		s2 + 1;
		ResultBuff			:=		FU_wFindAI;
		WHILE Str1Buff^ = s2^ OR s2^ = 0 DO
			IF s2^ = 0 THEN
				FU_wFindAI	:=		ResultBuff + 1;
				RETURN;
			END_IF
			s2				:=		s2 + 1;
			Str1Buff		:=		Str1Buff + 1;
			FU_wFindAI		:=		FU_wFindAI + 1;
		END_WHILE
		s2					:=		Str2Buff;
		FU_wFindAI			:=		ResultBuff;
	END_IF
	FU_wFindAI				:=		FU_wFindAI + 1;
	s1						:=		s1 + 1;
END_WHILE
FU_wFindAI					:=		0;