//This adds a declaration to the xml buffer, it must be the first thing, if added
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD AddDeclaration
VAR
	MethodID		:BYTE := 2;			//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND EOBReached = FALSE  THEN
	//Declaration starts
	AddChar(bChar		:=		EASCII.LessThan);

	//Declaration text added
	AddString(pString := ADR(XMLDeclaration) ,xFilled := FALSE ,dwFillerSize := 0);
	
	//Declaration ends
	AddChar(bChar 		:=		EASCII.GreatThan);

	//New Line
	AddNewLine();

	//Last Method is recorded
	LastMethod				:=		MethodID;
END_IF