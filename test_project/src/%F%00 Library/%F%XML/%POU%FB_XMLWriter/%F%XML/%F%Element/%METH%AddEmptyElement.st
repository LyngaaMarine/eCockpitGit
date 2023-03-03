//This adds a filled tag to the buffer, filled means that the size of the filler of the tag is defined, and if the provided data does not fill the size, the rest will be filled with #
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 25-04-18 | Creation
METHOD AddEmptyElement
VAR_INPUT
	pName			:POINTER TO BYTE;	//Address of string for the tag name text
END_VAR
VAR
	NameBuff		:POINTER TO BYTE;	//Address of string for the tag name text
END_VAR
VAR
	MethodID		:BYTE := 16;			//ID for keeping track of run methods
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND EOBReached = FALSE  THEN
	//Open Tag starts
	AddChar(bChar			:=		EASCII.LessThan);

	//Open tag text added
	NameBuff					:=		pName;
	IF pName^ <> EASCII.Null AND pName^ <> EASCII.Space THEN
		AddStringStrict(pString := pName ,xFilled := FALSE ,bFillerSize := 0);
	ELSE
		AddChar(bChar		:=		88);
	END_IF

	//Open tag ends
	AttPosBuffer				:=		FileBufferADR;		//Position of tag ending is saved for attribute addition
	AddChar(bChar			:=		EASCII.Solidus);
	AddChar(bChar			:=		EASCII.GreatThan);
	
	//New line
	AddNewLine();

	//Last Method is recorded
	LastMethod					:=		MethodID;
END_IF
