//This method returns the address of the cursor
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD GetPosAddress : POINTER TO BYTE
(*%!%__DELIMITER__%!%*)
IF Initialized THEN
	GetPosAddress		:=		ADRCursor;
END_IF