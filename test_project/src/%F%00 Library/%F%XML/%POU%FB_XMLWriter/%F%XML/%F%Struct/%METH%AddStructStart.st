{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This starts a new struct
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
// | 2         | NSN      | 25-04-18 | Added saving of attribute position
METHOD AddStructStart
VAR_INPUT
	pName			:POINTER TO BYTE;	//Address of string for the name text
END_VAR
VAR
	MethodID		:BYTE := 6;			//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND EOBReached = FALSE  AND TreeLevel <= 254 THEN
	//Struct tag starts
	AddChar(bChar			:=		EASCII.LessThan);
	
	//Address of struct name is saved
	TreeNames[TreeLevel]		:=		FileBufferADR;
	
	//struct tag text added
	IF pName^ > EASCII.Space THEN
		AddStringStrict(pString := pName, xFilled := FALSE, bFillerSize := 0);
	ELSE
		AddChar(bChar		:=		88);
	END_IF
	
	//struct tag ends
	AttPosBuffer				:=		FileBufferADR;		//Position of tag ending is saved for attribute addition
	AddChar(bChar			:=		EASCII.GreatThan);
	
	TreeLevel					:=		TreeLevel + 1;
	
	//New Line
	AddNewLine();
	
	//Last Method is recorded
	LastMethod					:=		MethodID;
END_IF