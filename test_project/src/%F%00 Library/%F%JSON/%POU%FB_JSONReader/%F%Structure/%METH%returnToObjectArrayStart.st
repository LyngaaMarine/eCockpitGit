//This method returns the cursor to the start of the json
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD returnToObjectArrayStart
(*%!%__DELIMITER__%!%*)
IF ready THEN
	lastValueStart		:=		0;
	lastValueType		:=		EStructType.none;
	lastKeyStart		:=		0;
END_IF