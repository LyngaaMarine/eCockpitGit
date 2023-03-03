{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This ends the previously started struct
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
METHOD AddStructEnd
VAR
	WatchDog		:BYTE;				//Watchdog for keeping addresse reading in check
	NameADR			:POINTER TO BYTE;	//Address of string for the name text
	MethodID		:BYTE := 7;			//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND TreeLevel > 0 AND EOBReached = FALSE  AND TreeNames[TreeLevel-1] <> 0 THEN
	//Last TAB is deleted
	FileBufferADR			:=		FileBufferADR - 1;
		
	//Struct tag starts
	AddChar(bChar		:=		EASCII.LessThan);
	AddChar(bChar		:=		EASCII.Solidus);
	
	//struct tag text added
	NameADR					:=		TreeNames[TreeLevel-1];

	IF NameADR <> 0 THEN						//Checks if stringaddress is not empty
		WHILE NameADR^ > EASCII.Space AND NameADR^ <> EASCII.GreatThan DO
			IF WatchDog >= 255 THEN
				EXIT;
			END_IF
			IF FileBufferADR < FileBufferMaxADR THEN	//In normal conditions
				FileBufferADR^		:=		NameADR^;	
				NameADR				:=		NameADR + 1;
				FileBufferADR		:=		FileBufferADR + 1;
				WatchDog			:=		WatchDog + 1;
			ELSE								//When the last address is encountered, the end of buffer variable is set true
				FileBufferADR^		:=		NameADR^;	
				EOBReached			:=		TRUE;
				BufferBroken		:=		TRUE;
				EXIT;
			END_IF
		END_WHILE
	END_IF
	
	//struct tag ends
	AddChar(bChar		:=		EASCII.GreatThan);
	
	TreeLevel				:=		TreeLevel - 1;
	
	//New Line
	AddNewLine();
	
	//Last Method is recorded
	LastMethod				:=		MethodID;
END_IF