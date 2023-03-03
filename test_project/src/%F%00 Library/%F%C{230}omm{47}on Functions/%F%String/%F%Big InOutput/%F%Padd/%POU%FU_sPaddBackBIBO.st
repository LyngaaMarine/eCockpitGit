{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function padds the back of a string with the given character, the given amount
//If the padd amount plus the string is longer than the output string, the input string will be cut off to make space for the padding
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 04-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sPaddBackBIBO : BOOL
VAR_IN_OUT
	sOut		:STRING(1);			//Output String
	sStr		:STRING(1);			//Input String
END_VAR
VAR_INPUT
	wPadds		:WORD;				//How much to padd it
	wOutSize	:WORD;				//Output String Size
	eChar		:EASCII;		//Which character to padd with
END_VAR
VAR
	In1Add		:POINTER TO BYTE;	//Address of first string
	StrAdd		:POINTER TO BYTE;	//Address of output string
END_VAR
!__IMPLEMENTATION__!
In1Add					:=		ADR(sStr);
StrAdd					:=		ADR(sOut);
IF wPadds = 0 THEN
	WHILE wOutSize > 0 DO
		wOutSize		:=		wOutSize - 1;
		IF In1Add^ <> 0 THEN
			StrAdd^		:=		In1Add^;
			In1Add		:=		In1Add + 1;
		ELSE
			EXIT;
		END_IF
		StrAdd			:=		StrAdd + 1;
	END_WHILE
	StrAdd^				:=		EASCII.Null;
ELSE
	WHILE wOutSize > 0 DO
		wOutSize		:=		wOutSize - 1;
		IF In1Add^ <> 0 THEN
			StrAdd^		:=		In1Add^;
			In1Add		:=		In1Add + 1;
		ELSIF wPadds > 0 THEN
			StrAdd^		:=		eChar;
			wPadds		:=		wPadds - 1;
		ELSE
			EXIT;
		END_IF
		StrAdd			:=		StrAdd + 1;
	END_WHILE
	StrAdd^				:=		EASCII.Null;
END_IF