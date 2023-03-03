//This functions deletes a part of a string values are counted from the right instead of the left
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 22-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sDeleteRightBIBO : BOOL
VAR_IN_OUT
	sOut		:STRING(1);			//Output String
	sStr		:STRING(1);		//Input String	
END_VAR
VAR_INPUT
	wLen		:WORD;				//Amount to trim from end
	wPos		:WORD;				//Position to delete from
	wOutSize	:WORD;				//Output String Size
END_VAR
VAR
	InAdd		:POINTER TO BYTE;	//Address of input string
	InAdd2		:POINTER TO BYTE;	//Address of input string
	StrAdd		:POINTER TO BYTE;	//Address of output string
	InSize		:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
InAdd				:=		ADR(sStr);
InAdd2				:=		ADR(sStr);
StrAdd				:=		ADR(sOut);
IF wPos > 0 THEN
	wPos			:=		wPos - 1;
END_IF
IF wLen > 0 THEN
	WHILE InAdd2^ <> 0 DO
		InAdd2		:=		InAdd2 + 1;
		InSize		:=		InSize + 1;
	END_WHILE
	IF wPos = 0 AND wLen >= InSize THEN
		StrAdd^		:=		0;
		RETURN;		
	ELSE
		IF InSize - wOutSize > wLen + wPos THEN
			wLen		:=		0;
			wPos		:=		0;
		ELSE
			IF InSize < wLen + wPos THEN
				wLen	:=		wLen - ((wLen + wPos) - InSize);
				wPos	:=		0;
			ELSE
				wPos	:=		InSize - wPos - wLen;		
			END_IF
		END_IF
	END_IF
	WHILE wPos > 0 DO
		wPos		:=		wPos - 1;
		IF InAdd^ = 0 OR wOutSize = 0 THEN
			StrAdd^	:=		0;
			RETURN;
		END_IF
		StrAdd^		:=		InAdd^;
		InAdd		:=		InAdd + 1;
		StrAdd		:=		StrAdd + 1;
		wOutSize	:=		wOutSize - 1;
	END_WHILE
	WHILE wLen > 0 DO
		wLen		:=		wLen - 1;
		IF InAdd^ = 0 THEN
			StrAdd^	:=		0;
			RETURN;
		END_IF
		InAdd		:=		InAdd + 1;
	END_WHILE
	WHILE InAdd^ <> 0 DO
		IF wOutSize = 0 THEN
			StrAdd^	:=		0;
			RETURN;			
		END_IF
		StrAdd^		:=		InAdd^;
		InAdd		:=		InAdd + 1;
		StrAdd		:=		StrAdd + 1;
		wOutSize	:=		wOutSize - 1;
	END_WHILE
	StrAdd^			:=		0;
ELSE
	WHILE InAdd^ <> 0 DO
		IF wOutSize = 0 THEN
			StrAdd^	:=		0;
			RETURN;			
		END_IF
		StrAdd^		:=		InAdd^;
		InAdd		:=		InAdd + 1;
		StrAdd		:=		StrAdd + 1;
		wOutSize	:=		wOutSize - 1;
	END_WHILE
	StrAdd^			:=		0;
END_IF