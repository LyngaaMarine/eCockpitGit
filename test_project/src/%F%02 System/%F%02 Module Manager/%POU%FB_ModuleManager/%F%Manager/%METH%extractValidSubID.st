//This extracts the subid from the file name
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-02-22 | Creation
METHOD extractValidSubID : AModuleSID
VAR_INPUT
	path			:APath;
END_VAR
VAR
	i				:BYTE;
	numberBuffer	:STRING(5);
END_VAR
(*%!%__DELIMITER__%!%*)
IF path[0] = EASCII.BigS THEN
	FOR i := 1 TO 5 DO
		IF path[i] >= EASCII.Zero AND path[i] <= EASCII.Nine THEN
			numberBuffer[i - 1]		:=		path[i];
		ELSIF path[i] = EASCII.SemiColon THEN
			numberBuffer[i - 1]		:=		0;
			extractValidSubID		:=		TO_WORD(numberBuffer);
			RETURN;		
		ELSE
			RETURN;
		END_IF
	END_FOR
	IF path[6] = EASCII.SemiColon THEN
		numberBuffer[5]				:=		0;
		extractValidSubID			:=		TO_WORD(numberBuffer);
		RETURN;
	END_IF	
END_IF