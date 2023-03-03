//This adds a filled tag to the buffer, filled means that the size of the filler of the tag is defined, and if the provided data does not fill the size, the rest will be filled with #
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
// | 2         | NSN      | 25-04-18 | added saving of attribute position
METHOD AddElement
VAR_INPUT
	pName			:POINTER TO BYTE;	//Address of string for the tag name text
	pFiller			:POINTER TO BYTE;	//Address of string for the filler text
	xFilled			:BOOL;				//If filler text should be used
	bFillerSize		:BYTE;				//Size of filler text, if filler does not fill the size, the empty spaces will be replaced with #
END_VAR
VAR
	NameADR2		:POINTER TO BYTE;	//Address of string for the tag name text
END_VAR
VAR
	MethodID		:BYTE := 9;			//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND EOBReached = FALSE  THEN
	//Open Tag starts
	AddChar(bChar			:=		EASCII.LessThan);

	//Open tag text added
	NameADR2					:=		pName;
	IF pName^ <> EASCII.Null AND pName^ <> EASCII.Space THEN
		AddStringStrict(pString := pName ,xFilled := FALSE ,bFillerSize := 0);
	ELSE
		AddChar(bChar		:=		88);
	END_IF

	//Open tag ends
	AttPosBuffer				:=		FileBufferADR;		//Position of tag ending is saved for attribute addition
	AddChar(bChar			:=		EASCII.GreatThan);

	//Filler text added
	AddString(pString := pFiller ,xFilled := xFilled ,dwFillerSize := bFillerSize);
	
	//Close Tag starts
	AddChar(bChar			:=		EASCII.LessThan);
	AddChar(bChar			:=		EASCII.Solidus);

	//Close tag text added
	IF NameADR2^ <> EASCII.Null AND NameADR2^ <> EASCII.Space THEN
		AddStringStrict(pString := NameADR2 ,xFilled := FALSE ,bFillerSize := 0);
	ELSE
		AddChar(bChar		:=		88);
	END_IF

	//Close tag ends
	AddChar(bChar			:=		EASCII.GreatThan);
	
	//New line
	AddNewLine();

	//Last Method is recorded
	LastMethod					:=		MethodID;
END_IF
