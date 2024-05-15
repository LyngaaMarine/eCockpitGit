{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This looks at an character and returns utf8 information about it
//It is not compatible with extended ascii (when all 8 bits are used)
// 0 means not utf-8 character
// 1 means start of utf-8 character
// 2 means middle of utf-8 character
// 3 means end of utf-8 character
// 4 means invalid
//It also returns the starting byte of the character
//To avoid cutting up utf 8 characters if this returns 1 or 2 when checking the end of a string, the string terminator should be moved to the start of the utf8 character
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 06-12-20 | Creation
FUNCTION FU_CheckUTF8 : BYTE
VAR_INPUT
	strStart	:POINTER TO BYTE;		//Starting address of string to prevent underflow
	char		:POINTER TO BYTE;		//Character to check
END_VAR
VAR_OUTPUT
	start		:POINTER TO BYTE;		//Start of utf8 character
END_VAR
VAR
	i			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF char <> 0 THEN
	IF char^.7 THEN
		IF char^.6 THEN
			FU_CheckUTF8		:=		1;
			start				:=		char;
		ELSE
			FOR i := 1 TO 6 DO
				char			:=		char - 1;
				IF char < strStart THEN
					RETURN;
				END_IF
				IF (char^ AND 2#11000000) = 192 THEN
					start		:=		char;
					IF char^.5 THEN
						IF char^.4 THEN
							IF char^.3 THEN
								IF char^.2 THEN
									IF char^.1 THEN
										FU_CheckUTF8			:=		4;
									ELSE
										IF i = 5 THEN
											FU_CheckUTF8		:=		3;
										ELSE
											FU_CheckUTF8		:=		2;
										END_IF
									END_IF
								ELSE
									IF i = 4 THEN
										FU_CheckUTF8		:=		3;
									ELSE
										FU_CheckUTF8		:=		2;
									END_IF
								END_IF
							ELSE
								IF i = 3 THEN
									FU_CheckUTF8		:=		3;
								ELSE
									FU_CheckUTF8		:=		2;
								END_IF
							END_IF
						ELSE
							IF i = 2 THEN
								FU_CheckUTF8		:=		3;
							ELSE
								FU_CheckUTF8		:=		2;
							END_IF
						END_IF
					ELSE
						IF i = 1 THEN
							FU_CheckUTF8		:=		3;
						ELSE
							FU_CheckUTF8		:=		2;
						END_IF
					END_IF
					RETURN;
				END_IF
			END_FOR
		END_IF
	ELSE
		FU_CheckUTF8			:=		0;
	END_IF
END_IF