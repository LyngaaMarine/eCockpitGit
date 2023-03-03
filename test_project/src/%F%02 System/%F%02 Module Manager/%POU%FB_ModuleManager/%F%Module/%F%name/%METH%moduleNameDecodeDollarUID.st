METHOD moduleNameDecodeDollarUID : POINTER TO FB_Module
VAR_INPUT
	first		:POINTER TO EASCII;
END_VAR
VAR_OUTPUT
	offSet		:BYTE;
END_VAR
VAR
	i			:BYTE;
	buff		:STRING(5);
END_VAR
(*%!%__DELIMITER__%!%*)
FOR i := 0 TO 4 DO
	IF first^ >= EASCII.Zero AND first^ <= EASCII.Nine THEN
		buff[i]					:=		first^;
		first					:=		first + 1;
	ELSE 
		EXIT;
	END_IF
END_FOR
first							:=		first + 1;
buff[i]							:=		0;
IF buff[0] >= EASCII.Zero AND buff[0] <= EASCII.Nine THEN
	moduleNameDecodeDollarUID		:=		GMod.modMan.getModuleByUID(ModUID:=TO_WORD(buff));
	offSet						:=		i + 2;
ELSE
	offSet						:=		3;
END_IF