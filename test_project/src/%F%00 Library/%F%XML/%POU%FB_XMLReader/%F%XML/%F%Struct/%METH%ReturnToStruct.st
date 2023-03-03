//This method returns the cursor to the previusly found struct if one has been found
//Returns true when succesful
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-06-18 | Creation
METHOD ReturnToStruct :BOOL
(*%!%__DELIMITER__%!%*)
IF Initialized AND StructPositions[StructPosOffset] <> 0 THEN
	IF ADRCursor <> StructPositions[StructPosOffset] THEN
		ADRCursor			:=		StructPositions[StructPosOffset];
		ReturnToStruct		:=		TRUE;
	ELSE
		StructPositions[StructPosOffset]	:=		0;
		IF StructPosOffset = 0 THEN
			StructPosOffset		:=		254;
		ELSE
			StructPosOffset		:=		StructPosOffset - 1;
		END_IF
		IF StructPosOffset2 = 0 THEN
			StructPosOffset2	:=		254;
		ELSE
			StructPosOffset2	:=		StructPosOffset2 - 1;
		END_IF
		IF StructPositions[StructPosOffset] <> 0 THEN
			ADRCursor				:=		StructPositions[StructPosOffset];
			ReturnToStruct			:=		TRUE;
		END_IF
	END_IF
END_IF
