{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function find a string in another string, and returns the position of the found string.
//This version will skip the found location, the amount given.
//It returns 0 if nothing is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
FUNCTION FU_wFindSkipBI : WORD
VAR_IN_OUT
	s1			:STRING(1);		//Input String1
	s2			:STRING(1);		//Input String2
END_VAR
VAR_INPUT
	skipAmount	:WORD;					//Amount to skip
END_VAR
VAR
	pStr1		:POINTER TO BYTE;	//Address of source string
	pStr2		:POINTER TO BYTE;	//Address of source string
	Str1Buff	:POINTER TO BYTE;		//Buffer address for string1
	Str2Buff	:POINTER TO BYTE;	//Buffer address for string2
	ResultBuff	:WORD;
END_VAR
!__IMPLEMENTATION__!
pStr1							:=		ADR(s1);
pStr2							:=		ADR(s2);
Str2Buff						:=		ADR(s2);
WHILE pStr1^ <> 0 DO
	IF pStr1^ = pStr2^ THEN
		Str1Buff				:=		pStr1 + 1;
		pStr2					:=		pStr2 + 1;
		ResultBuff				:=		FU_wFindSkipBI;
		WHILE Str1Buff^ = pStr2^ OR pStr2^ = 0 DO
			IF pStr2^ = 0 THEN
				FU_wFindSkipBI	:=		ResultBuff + 1;
				IF skipAmount = 0 THEN
					RETURN;
				ELSE
					skipAmount	:=		skipAmount - 1;
					EXIT;
				END_IF
			END_IF
			pStr2				:=		pStr2 + 1;
			Str1Buff			:=		Str1Buff + 1;
			FU_wFindSkipBI		:=		FU_wFindSkipBI + 1;
		END_WHILE
		pStr2					:=		Str2Buff;
		FU_wFindSkipBI			:=		ResultBuff;
	END_IF
	FU_wFindSkipBI				:=		FU_wFindSkipBI + 1;
	pStr1						:=		pStr1 + 1;
END_WHILE
FU_wFindSkipBI					:=		0;