//This method moves the cursor to the next struct by the given name from the cursor
//Returns true if found
//Returns cursor to where it was before if no tag is found
//Cursor is set at end of struct name if found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
// | 2         | NSN      | 07-06-18 | Added function to only search in the struct it is inside + added saving of the last 20 found structs
METHOD MoveToStruct : BOOL
VAR_INPUT
	pName			:POINTER TO BYTE;		//Address of the name to find, only input string address or zero terminated byte array
	xInStruct		:BOOL;					//If it should only search within the last struct, on the same layer, only works reliably when searching from the start of a struct, 
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;		//Buffer for cursor position
	TreeBuffer		:INT;					//buffer for tree layer
	EndFound		:BOOL;					//If end is found
END_VAR
(*%!%__DELIMITER__%!%*)
IF Initialized AND pName <> 0 THEN											//It only runs when a buffer has been initialized
	CursorBuffer							:=		ADRCursor;				//Cursor is saved in buffer
	TreeBuffer								:=		TreeLevel;				//Treelevel is saved in buffer

	WHILE MoveToString(pText:= ADR(XMLStartTag), dwAmount:= 1, xInTag := FALSE, xImediate :=FALSE) DO
		IF xInStruct THEN
			IF TreeLevel < TreeBuffer THEN
				EXIT;
			END_IF
		END_IF
		IF NOT(xInStruct) OR TreeLevel = TreeBuffer + 1 THEN;
			IF MoveToString(pText:= pName, dwAmount:= InLength(pName), xInTag := FALSE, xImediate := TRUE) THEN
				IF MoveToString(pText:= ADR(XMLSpace), dwAmount:= 1, xInTag := FALSE, xImediate := TRUE) THEN
					EndFound				:=		TRUE;
				ELSIF MoveToString(pText:= ADR(XMLEndTag), dwAmount:= 1, xInTag := FALSE, xImediate := TRUE) THEN
					EndFound				:=		TRUE;
				END_IF
					
				IF EndFound AND NOT(CheckTag()) THEN
					MoveToStruct			:=		TRUE;
					MarkStruct();
					RETURN;
				END_IF
			END_IF
		END_IF
	END_WHILE
	
	ADRCursor								:=		CursorBuffer;		
	TreeLevel								:=		TreeBuffer;
END_IF