//This method returns the cursor to the start of the json
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD returnToStart
(*%!%__DELIMITER__%!%*)
IF ready THEN
	CASE buttomType OF
		EStructType.object,EStructType.tArray:
			treeLevel			:=		1;
			lastValueStart		:=		0;
			lastValueType		:=		EStructType.none;
			lastKeyStart		:=		0;
	END_CASE
END_IF