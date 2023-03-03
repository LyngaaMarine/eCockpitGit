//This method returns the cursor to the start of the xml file
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD ReturnToStart
(*%!%__DELIMITER__%!%*)
IF Initialized THEN
	ADRCursor		:=		DeclarationEnd;
	TreeLevel		:=		0;
END_IF