//This function find a string in another string, and returns the position of the found string.
//It returns 0 if nothing is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
FUNCTION FU_wFindBI : WORD
VAR_IN_OUT
	s1			:STRING(1);		//Input String1
	s2			:STRING(1);		//Input String2
END_VAR
VAR
	pStr1		:POINTER TO BYTE;	//Address of source string
	pStr2		:POINTER TO BYTE;	//Address of source string
	Str1Buff	:POINTER TO BYTE;				//Buffer address for string1
	Str2Buff	:POINTER TO BYTE;	//Buffer address for string2
	ResultBuff	:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
pStr1		 :=		ADR(s1);
pStr2		 :=		ADR(s2);
Str2Buff	 :=		ADR(s2);

WHILE pStr1^ <> 0 DO
	IF pStr1^ = pStr2^ THEN
		Str1Buff			:=		pStr1 + 1;
		pStr2				:=		pStr2 + 1;
		ResultBuff			:=		FU_wFindBI;
		WHILE Str1Buff^ = pStr2^ OR pStr2^ = 0 DO
			IF pStr2^ = 0 THEN
				FU_wFindBI	:=		ResultBuff + 1;
				RETURN;
			END_IF
			pStr2			:=		pStr2 + 1;
			Str1Buff		:=		Str1Buff + 1;
			FU_wFindBI		:=		FU_wFindBI + 1;
		END_WHILE
		pStr2				:=		Str2Buff;
		FU_wFindBI			:=		ResultBuff;
	END_IF
	FU_wFindBI				:=		FU_wFindBI + 1;
	pStr1					:=		pStr1 + 1;
END_WHILE
FU_wFindBI					:=		0;