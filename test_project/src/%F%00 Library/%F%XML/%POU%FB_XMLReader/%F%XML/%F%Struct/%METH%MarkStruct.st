//This method marks the current cursor address at a struct which can be returned to 
//Can be used to mark a found attrubute as being within a struct
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-06-18 | Creation
METHOD MarkStruct 
(*%!%__DELIMITER__%!%*)
IF Initialized THEN
	StructPositions[StructPosOffset2]	:=		ADRCursor;
	IF StructPosOffset >= 254 THEN												//Calculates next free space in buffer
		StructPosOffset		:=		0;
	ELSE
		StructPosOffset		:=		StructPosOffset + 1;
	END_IF
	IF StructPosOffset2 >= 254 THEN												//Calculates next free space in buffer
		StructPosOffset2	:=		0;
	ELSE
		StructPosOffset2	:=		StructPosOffset2 + 1;
	END_IF
END_IF
