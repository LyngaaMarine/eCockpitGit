//This decodes an utf8 character and returns the unicode number
//Supports up to 6 byte encoding
//Returns 0 when invalid character is found
//Lenght of utf8 character is also returned, if the character is invalid, the length where ivalidity was found is returned.
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-12-20 | Creation
FUNCTION FU_UTF8GetUnicode : DWORD
VAR_INPUT
	char		:POINTER TO BYTE;
END_VAR
VAR_OUTPUT
	len			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
IF char = 0 THEN
	FU_UTF8GetUnicode												:=		0;
END_IF
CASE char^ OF
	128..255:
		IF char^.6 THEN
			IF char^.5 THEN
				IF char^.4 THEN
					IF char^.3 THEN
						IF char^.2 THEN
							FU_UTF8GetUnicode						:=		SHL(TO_DWORD(char^ AND 2#00000011),30);
							char									:=		char + 1;
							IF char^.7 AND NOT char^.6 THEN
								FU_UTF8GetUnicode					:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),24);
								char								:=		char + 1;
								IF char^.7 AND NOT char^.6 THEN
									FU_UTF8GetUnicode				:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),18);
									char							:=		char + 1;
									IF char^.7 AND NOT char^.6 THEN
										FU_UTF8GetUnicode			:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),12);
										char						:=		char + 1;
										IF char^.7 AND NOT char^.6 THEN
											FU_UTF8GetUnicode		:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),6);
											char					:=		char + 1;
											IF char^.7 AND NOT char^.6 THEN
												FU_UTF8GetUnicode	:=		FU_UTF8GetUnicode OR (char^ AND 2#00111111);
												len					:=		6;
											ELSE	//Invalid utf returns 0
												FU_UTF8GetUnicode	:=		0;
												len					:=		5;
											END_IF
										ELSE	//Invalid utf returns 0
											FU_UTF8GetUnicode		:=		0;
											len						:=		4;
										END_IF
									ELSE	//Invalid utf returns 0
										FU_UTF8GetUnicode			:=		0;
										len							:=		3;
									END_IF
								ELSE	//Invalid utf returns 0
									FU_UTF8GetUnicode				:=		0;
									len								:=		2;
								END_IF
							ELSE	//Invalid utf returns 0
								FU_UTF8GetUnicode					:=		0;
								len									:=		1;
							END_IF
						ELSE	//5 byte encoding
							FU_UTF8GetUnicode						:=		SHL(TO_DWORD(char^ AND 2#00000011),24);
							char									:=		char + 1;
							IF char^.7 AND NOT char^.6 THEN
								FU_UTF8GetUnicode					:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),18);
								char								:=		char + 1;
								IF char^.7 AND NOT char^.6 THEN
									FU_UTF8GetUnicode				:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),12);
									char							:=		char + 1;
									IF char^.7 AND NOT char^.6 THEN
										FU_UTF8GetUnicode			:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),6);
										char						:=		char + 1;
										IF char^.7 AND NOT char^.6 THEN
											FU_UTF8GetUnicode		:=		FU_UTF8GetUnicode OR (char^ AND 2#00111111);
												len					:=		5;
										ELSE	//Invalid utf returns 0
											FU_UTF8GetUnicode		:=		0;
											len						:=		4;
										END_IF
									ELSE	//Invalid utf returns 0
										FU_UTF8GetUnicode			:=		0;
										len							:=		3;
									END_IF
								ELSE	//Invalid utf returns 0
									FU_UTF8GetUnicode				:=		0;
									len								:=		2;
								END_IF
							ELSE	//Invalid utf returns 0
								FU_UTF8GetUnicode					:=		0;
								len									:=		1;
							END_IF
						END_IF
					ELSE	//4 byte encoding
						FU_UTF8GetUnicode							:=		SHL(TO_DWORD(char^ AND 2#00000111),18);
						char										:=		char + 1;
						IF char^.7 AND NOT char^.6 THEN
							FU_UTF8GetUnicode						:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),12);
							char									:=		char + 1;
							IF char^.7 AND NOT char^.6 THEN
								FU_UTF8GetUnicode					:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),6);
								char								:=		char + 1;
								IF char^.7 AND NOT char^.6 THEN
									FU_UTF8GetUnicode				:=		FU_UTF8GetUnicode OR (char^ AND 2#00111111);
									len								:=		4;
								ELSE	//Invalid utf returns 0
									FU_UTF8GetUnicode				:=		0;
									len								:=		3;
								END_IF
							ELSE	//Invalid utf returns 0
								FU_UTF8GetUnicode					:=		0;
								len									:=		2;
							END_IF
						ELSE	//Invalid utf returns 0
							FU_UTF8GetUnicode						:=		0;
							len										:=		1;
						END_IF
					END_IF
				ELSE	//3 byte encoding
					FU_UTF8GetUnicode								:=		SHL(TO_DWORD(char^ AND 2#00001111),12);
					char											:=		char + 1;
					IF char^.7 AND NOT char^.6 THEN
						FU_UTF8GetUnicode							:=		FU_UTF8GetUnicode OR SHL(TO_DWORD(char^ AND 2#00111111),6);
						char										:=		char + 1;
						IF char^.7 AND NOT char^.6 THEN
							FU_UTF8GetUnicode						:=		FU_UTF8GetUnicode OR (char^ AND 2#00111111);
							len										:=		3;
						ELSE	//Invalid utf returns 0
							FU_UTF8GetUnicode						:=		0;
							len										:=		2;
						END_IF
					ELSE	//Invalid utf returns 0
						FU_UTF8GetUnicode							:=		0;
						len											:=		1;
					END_IF
				END_IF
			ELSE	//2 byte encoding
				FU_UTF8GetUnicode									:=		SHL(TO_DWORD(char^ AND 2#00011111),6);
				char												:=		char + 1;
				IF char^.7 AND NOT char^.6 THEN
					FU_UTF8GetUnicode								:=		FU_UTF8GetUnicode OR (char^ AND 2#00111111);
					len												:=		2;
				ELSE	//Invalid utf returns 0
					FU_UTF8GetUnicode								:=		0;
					len												:=		1;
				END_IF
			END_IF
		ELSE	//Invalid utf returns 0
			FU_UTF8GetUnicode										:=		0;
			len														:=		1;
		END_IF
ELSE	//Characters in the ascii area
	FU_UTF8GetUnicode												:=		char^;
	len																:=		1;
END_CASE