//This method copies the found attribute value to an address
//Returns true when succesfull
//Only works when MoveToAtt has successfully found an attribute
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 01-06-18 | Creation
METHOD CopyAttVal: BOOL;
VAR_INPUT
	pCopyTo			:POINTER TO BYTE;	//Address of the move to place
	wCopyToMax		:DWORD;				//Max size of the copy to adress
	xEndString		:BOOL;				//If a zero should be added to the end of the copy to adresse
END_VAR
VAR_OUTPUT
	xMoreData		:BOOL;				//True when there is more data avaliable than the size of the destination
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;	//Buffer for cursor position
	CopyAmount		:DWORD;				//Copy amount
END_VAR

//Version 1 by NSN 01-06-18  Changes: Creation

(*%!%__DELIMITER__%!%*)
IF Initialized AND AttDataBuffer <> 0 THEN			//Makes sure it only runs after an attribute has been found
	CursorBuffer		:=		ADRCursor;			//Cursor adress is saved
	ADRCursor			:=		AttDataBuffer;		//Cursor is set to attribute position
	CopyAmount			:=		CountToString(pText:= ADR(XMLDoubleQoute), dwAmount:= 1, xInTag:=FALSE);	//Attribute value size is determinded
	IF CopyAmount > wCopyToMax THEN					//If size of destination variable is smaller than attribute value size
		CopyAmount		:=		wCopyToMax;			//Decreses amount to copy if above
		xMoreData		:=		TRUE;				//Warning that there is more data available
	END_IF
	CopyReadData(pCopyTo:= pCopyTo, dwAmount:= CopyAmount, xEndString:= xEndString);	//Attribute data is copied
	ADRCursor			:=		CursorBuffer;		//Cursor is returned
	CopyAttVal			:=		TRUE;				//Returns succesfull
END_IF