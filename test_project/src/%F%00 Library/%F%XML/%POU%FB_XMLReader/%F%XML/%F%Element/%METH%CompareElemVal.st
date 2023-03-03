//This method compares the last found tag value to a given string
//Only works if a MoveToTag, was succesfull
//Returns false if the strings are the same
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-12-18 | Creation
METHOD CompareElemVal: BOOL
VAR_IN_OUT
	pCompareString	:STRING(1);
END_VAR
VAR
	pStr1			:POINTER TO BYTE := ADR(pCompareString);	//Address of source string
	cursorBuffer	:POINTER TO BYTE;		//Buffer for cursor position
	copyAmount		:DWORD;					//Amount to copy
	searchString	:STRING(2) := '</';		//For finding end of tag
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND TagDataBuffer <> 0 THEN			//Makes sure it only runs after an tag has been found
	cursorBuffer		:=		ADRCursor;			//Cursor is saved
	ADRCursor			:=		TagDataBuffer;		//Cursor is moved to where tag data begins
	copyAmount			:=		CountToString(pText:= ADR(searchString), dwAmount:=2, xInTag:=FALSE);	//Size of tag data is found
	//When there is either more left on the old or the new string
	WHILE pStr1^ <> 0 OR copyAmount > 0 DO
		//If the old string reaches the end, it is not eqal to the new string
		IF copyAmount = 0 THEN
			CompareElemVal		:=		TRUE;
			EXIT;			
		END_IF
		//If the new string reaches the end, it is not eqal to the old string
		IF pStr1^ = 0 THEN
			CompareElemVal		:=		TRUE;
			EXIT;			
		END_IF
		//If a difference between the two strings is found
		IF pStr1^ <> ADRCursor^ THEN
			CompareElemVal		:=		TRUE;
			EXIT;
		END_IF
		copyAmount		:=		copyAmount - 1;
		ADRCursor		:=		ADRCursor + 1;
		pStr1			:=		pStr1 + 1;
	END_WHILE
	ADRCursor			:=		cursorBuffer;		//Cursor is returned
END_IF