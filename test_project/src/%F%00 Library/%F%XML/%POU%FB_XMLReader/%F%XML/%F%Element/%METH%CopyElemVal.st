{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method copies  the last found tags value to an address, if found
//Only works if a MoveToTag, was succesfull
//Returns true if all is good
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
// | 2         | NSN      | 21-06-18 | Fixed error where empty element would return wrong data
METHOD CopyElemVal: BOOL
VAR_INPUT
	pCopyTo			:POINTER TO BYTE;		//Address of the move to place
	dwCopyToMax		:DWORD;					//Max size of the copy to adress
	xEndString		:BOOL;					//If a zero should be added to the end of the copy to adresse
END_VAR
VAR_OUTPUT
	MoreData		:BOOL;					//True when there is more data avaliable than the size of the destination
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;		//Buffer for cursor position
	CopyAmount		:DWORD;					//Amount to copy
	SearchString	:STRING(2) := '</';		//For finding end of tag
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND TagDataBuffer <> 0 THEN			//Makes sure it only runs after an tag has been found
	IF TagDataBuffer^ = EASCII.LessThan THEN
		pCopyTo^			:=		0;
		RETURN;
		CopyElemVal		:=		TRUE;				//Returns succesfull
	END_IF
	CursorBuffer		:=		ADRCursor;			//Cursor is saved
	ADRCursor			:=		TagDataBuffer;		//Cursor is moved to where tag data begins
	CopyAmount			:=		CountToString(pText:= ADR(SearchString), dwAmount:=2, xInTag:=FALSE);	//Size of tag data is found
	IF CopyAmount > dwCopyToMax THEN					//If size of destination variable is smaller than tag value size
		CopyAmount		:=		dwCopyToMax;			//Decreses amount to copy if above
		MoreData		:=		TRUE;				//Warning that there is more data available
	END_IF
	CopyReadData(pCopyTo:= pCopyTo, dwAmount:= CopyAmount, xEndString:= xEndString);	//Tag data is copied
	ADRCursor			:=		CursorBuffer;		//Cursor is returned
	CopyElemVal			:=		TRUE;				//Returns succesfull
END_IF