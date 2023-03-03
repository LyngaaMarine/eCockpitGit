//This adds a new line and the appropriate amount of tabs
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD PROTECTED AddNewLine
VAR
	FOR1			:BYTE;
	MethodID		:BYTE := 4;			//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND EOBReached = FALSE  THEN
	//New Line
	AddChar(bChar := EASCII.CR);
	AddChar(bChar := EASCII.LF);
	
	//Tabs are added
	IF TreeLevel > 0 THEN
		FOR FOR1 := TreeLevel TO 1 BY -1 DO
			AddChar(bChar := EASCII.Tab);
		END_FOR
	END_IF
	
	//Last Method is recorded
	LastMethod					:=		MethodID;
END_IF
