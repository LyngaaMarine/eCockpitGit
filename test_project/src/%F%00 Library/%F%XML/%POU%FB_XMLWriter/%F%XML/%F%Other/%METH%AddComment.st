{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This adds a comment to the xml buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD AddComment
VAR_INPUT
	pText			:POINTER TO BYTE;	//Address of string for the comment text
END_VAR
VAR
	MethodID		:BYTE := 5;			//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND EOBReached = FALSE  THEN
	//Comment starts
	AddChar(bChar		:=		EASCII.LessThan);
	AddChar(bChar		:=		EASCII.Exclamation);
	AddChar(bChar		:=		EASCII.Minus);
	AddChar(bChar		:=		EASCII.Minus);
	
	//Comment text added
	AddStringStrict(pString := pText ,xFilled := FALSE ,bFillerSize := 0);
	
	//Comment ends
	AddChar(bChar		:=		EASCII.Minus);
	AddChar(bChar		:=		EASCII.Minus);
	AddChar(bChar		:=		EASCII.GreatThan);
	
	//New Line
	AddNewLine();
	
	//Last Method is recorded
	LastMethod				:=		MethodID;
END_IF
