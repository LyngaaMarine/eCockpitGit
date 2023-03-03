{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method moves the cursor to the next attribute by the given name from the cursor
//Returns true if found
//Returns cursor if no attribute is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 01-06-18 | Creation
// | 2         | NSN      | 07-06-18 | Name length is calculated in method
METHOD MoveToAtt :BOOL
VAR_INPUT
	pName			:POINTER TO BYTE;		//Address of the name to find, only input string address or zero terminated byte array
	xInLayer		:BOOL;					//If it should only search within the last struct, on the same layer, only works reliably when searching from the start of a struct, 
	xInTag			:BOOL;					//If it should stop scanning at the first tag end
END_VAR
VAR
	CursorBuffer	:POINTER TO BYTE;		//Buffer for cursor position
	TreeBuffer		:INT;					//buffer for tree layer
	NameLength		:DWORD;
	HighestLevel	:INT;
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND pName <> 0 THEN										//It only runs when a buffer has been initialized
	CursorBuffer							:=		ADRCursor;				//Cursor is saved in buffer
	TreeBuffer								:=		TreeLevel;				//Treelevel is saved in buffer
	NameLength								:=		InLength(pName);
	
	WHILE MoveToString(pText:= ADR(XMLEqual), dwAmount:= 1, xInTag := xInTag, xImediate :=FALSE, HighestLevel => HighestLevel) DO
		IF xInLayer THEN
			IF HighestLevel < TreeBuffer THEN
				EXIT;
			END_IF
		END_IF
		IF NOT(xInLayer) OR TreeLevel = TreeBuffer + 1 THEN;
			IF MoveToString(pText:= ADR(XMLDoubleQoute), dwAmount:= 1, xInTag := TRUE, xImediate := TRUE) THEN
				AttDataBuffer				:=		ADRCursor + 1;
				ADRCursor 					:=		ADRCursor - (NameLength + 3);
				IF MoveToString(pText:= ADR(XMLSpace), dwAmount:= 1, xInTag := TRUE, xImediate := TRUE) THEN
					IF MoveToString(pText:= pName, dwAmount:= NameLength, xInTag := TRUE, xImediate := TRUE) THEN
						MoveToAtt			:=		TRUE;
						IF CheckTag() THEN
							IF MoveToString(pText:= ADR(XMLEndTag), dwAmount:= 1, xInTag := FALSE, xImediate := FALSE) THEN
								TagDataBuffer	:=		ADRCursor + 1;
							END_IF						
						END_IF
						ADRCursor			:=		AttDataBuffer;
						RETURN;
					ELSE
						ADRCursor 			:=		AttDataBuffer - 1;
						AttDataBuffer		:=		0;
					END_IF
				ELSE
					ADRCursor 				:=		AttDataBuffer - 1;
					AttDataBuffer			:=		0;
				END_IF
			END_IF
		END_IF
	END_WHILE
	
	ADRCursor								:=		CursorBuffer;		
	TreeLevel								:=		TreeBuffer;
	
END_IF