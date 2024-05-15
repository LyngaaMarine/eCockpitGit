{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method finds the key of the given name in the object
//Returns cursor to where it was before if no tag is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD findKey : EStructType
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
END_VAR
VAR
	inString		:BOOL;
	nameBuffer		:POINTER TO EASCII;		//Buffer for cursor position
	posBuffer		:POINTER TO EASCII := treeSelected[treeLevel];
	level			:WORD;		//This value makes sure it doesn't return a key from inside another object
	foundKeyBuffer	:POINTER TO EASCII;
	slashDepth		:WORD;
END_VAR
!__IMPLEMENTATION__!
IF ready AND treeLevel > 0 AND treeSelectedTypes[treeLevel] = EStructType.object THEN
	WHILE posBuffer <= bufferADRMax DO
		CASE posBuffer^ OF
			EASCII.Null:EXIT;
			EASCII.DoubleQoute: IF checkNoBackSlash(checkPos:=posBuffer) THEN inString := NOT(inString); END_IF
			EASCII.CloseBraces,EASCII.SqBracketC: IF NOT(inString) THEN IF level > 1 THEN level := level - 1;ELSE EXIT; END_IF END_IF
			EASCII.SqBracketO: IF NOT(inString) THEN level := level + 1;END_IF
			EASCII.Comma,EASCII.OpenBraces:
				IF NOT(inString) THEN
					IF posBuffer^ = EASCII.OpenBraces THEN
						level									:=		level + 1;
					END_IF
					IF level = 1 THEN
						WHILE posBuffer <= bufferADRMax DO
							posBuffer							:=		posBuffer + 1;
							CASE posBuffer^ OF
								EASCII.Null:EXIT;
								EASCII.DoubleQoute:
									inString										:=		TRUE;
									nameBuffer										:=		name;
									foundKeyBuffer									:=		posBuffer;
									posBuffer										:=		posBuffer + 1;
									WHILE posBuffer <= bufferADRMax DO
										IF nameBuffer^ = EASCII.Null AND_THEN posBuffer^ = EASCII.DoubleQoute THEN
											WHILE posBuffer <= bufferADRMax DO
												CASE posBuffer^ OF
													EASCII.Null:EXIT;
													EASCII.DoubleQoute:
														IF checkNoBackSlash(checkPos:=posBuffer) THEN
															inString := NOT(inString);
														END_IF
													EASCII.Colon:
														IF NOT(inString) THEN
															findKey					:=		getType(valueFirstByte:=posBuffer + 1,valuePos=>lastValueStart);
															lastKeyStart			:=		foundKeyBuffer;
															lastValueType			:=		findKey;
															RETURN;
														END_IF	
												END_CASE
												posBuffer							:=		posBuffer + 1;
											END_WHILE
										END_IF
										//Check for escape character
										IF nameBuffer^ = EASCII.DoubleQoute OR posBuffer^ = EASCII.BackSlash THEN
											posBuffer								:=		posBuffer + 1;
											IF posBuffer^ <> EASCII.DoubleQoute THEN
												posBuffer							:=		posBuffer - 1;
											END_IF
										END_IF
										IF posBuffer^ <> nameBuffer^ OR posBuffer^ = EASCII.Null THEN
											IF posBuffer^ = EASCII.DoubleQoute THEN
												IF checkNoBackSlash(checkPos:=posBuffer) THEN
													inString := NOT(inString);
												END_IF
											END_IF
											EXIT;
										END_IF
										nameBuffer									:=		nameBuffer + 1;
										posBuffer									:=		posBuffer + 1;
									END_WHILE
									EXIT;
							END_CASE
						END_WHILE
					END_IF
				END_IF
		END_CASE	
		posBuffer																	:=		posBuffer + 1;
	END_WHILE
	findKey																			:=		EStructType.none;
END_IF