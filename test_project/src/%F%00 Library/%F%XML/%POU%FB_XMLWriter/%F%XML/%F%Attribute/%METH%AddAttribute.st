{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This adds an attribute to a tag
//Only works for struct start for now
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 24-01-18 | Creation
METHOD AddAttribute
VAR_INPUT
	pName			:POINTER TO BYTE;	//Address of string for the attribute name
	pText			:POINTER TO BYTE;	//Address of string for the attribute text
	xFilled			:BOOL;				//If filler text should be used
	bFillerSize		:BYTE;				//Size of filler text, if filler does not fill the size, the empty spaces will be replaced with #
END_VAR
VAR
	MoveAmount		:DWORD;
	AttSize			:DWORD;
	TextSize		:DWORD;
	PosBuffer		:POINTER TO BYTE;	
	MethodID		:BYTE := 12;		//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND EOBReached = FALSE  THEN
	IF LastMethod = 6 OR LastMethod = 12 OR LastMethod = 9 OR LastMethod = 16 THEN
		//Size of attribute is calculated
		TextSize				:=		LenStrict(pString:= pText);
		AttSize					:=		LenStrict(pString:= pName) + TextSize + 4;
		IF xFilled THEN
			AttSize				:=		AttSize + (bFillerSize - TextSize);
		END_IF
		//If the name string is empty, an x is written instead, this is accounted for here	
		IF pName^ = EASCII.Null OR pName^ = EASCII.Space THEN
			AttSize				:=		AttSize + 1;	
		END_IF
		MoveAmount				:=		FileBufferADR - AttPosBuffer;

		//Text is copied further down the buffer to make room for attribute		
		CopyBufferContent(pMoveFrom:= AttPosBuffer, pMoveTo:= AttPosBuffer + AttSize, dwAmount:= MoveAmount);
	
		//Position is calculated for afterwards
		PosBuffer				:=		FileBufferADR + AttSize;
		FileBufferADR			:=		AttPosBuffer;
		
		//Attribute starts
		AddChar(bChar		:=		EASCII.Space);

		//Attribute name is added
		IF pName^ <> EASCII.Null AND pName^ <> EASCII.Space THEN
			AddStringStrict(pString := pName ,xFilled := FALSE ,bFillerSize := 0);
		ELSE
			AddChar(bChar		:=		88);
		END_IF
		
		//Attribute middle
		AddChar(bChar		:=		EASCII.Equal);
		AddChar(bChar		:=		EASCII.DoubleQoute);
		
		//Attribute text is added
		AddStringStrict(pString := pText, xFilled := xFilled, bFillerSize := bFillerSize);
	
		//Attribute end
		AddChar(bChar		:=		EASCII.DoubleQoute);
		AttPosBuffer			:=		FileBufferADR;		//Position of tag ending is saved for attribute addition
	
		FileBufferADR			:=		PosBuffer;

		//Last Method is recorded
		LastMethod				:=		MethodID;
	END_IF
END_IF
