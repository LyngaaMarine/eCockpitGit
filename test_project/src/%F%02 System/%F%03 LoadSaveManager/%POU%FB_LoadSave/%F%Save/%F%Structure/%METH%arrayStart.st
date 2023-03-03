//This starts a new array
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD arrayStart : BOOL
VAR_INPUT
	singleLine		:BOOL;
END_VAR
(*%!%__DELIMITER__%!%*)
arrayStart		:=		writer.arrayStart(singleLine:=singleLine);
IF doLogInt THEN
	IF selectedType = EStructType.tArray THEN
		reader.nextArray();
	END_IF
	IF NOT(reader.enterObjectArray()) THEN
		logCorrection		:=		logCorrection + 1;
	END_IF
END_IF