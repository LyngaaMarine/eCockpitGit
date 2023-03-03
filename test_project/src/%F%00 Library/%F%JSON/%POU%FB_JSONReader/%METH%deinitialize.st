//This method deinitializes the reader, resetting all internal values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-06-18 | Creation
// | 2         | NSN      | 21-06-18 | Added missing values, needed to be reset
METHOD deinitialize

(*%!%__DELIMITER__%!%*)
IF ready THEN
	//Values are reset
	bufferADRMax				:=		0;
	bufferADROrg				:=		0;
	buttomType					:=		EStructType.none;
	lastValueStart				:=		0;
	lastValueType				:=		EStructType.none;
	lastKeyStart				:=		0;
	treeLevel					:=		0;
	ready						:=		FALSE;	
END_IF