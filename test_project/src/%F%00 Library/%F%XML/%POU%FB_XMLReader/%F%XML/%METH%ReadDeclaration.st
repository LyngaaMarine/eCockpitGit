{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method returns the values of the xml declaration
//It returns true if the declaration is ok
//Sets cursor to end of declaration
//Only works if declaration is placed on the first position of the first line, and if version is the first 
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 31-05-18 | Creation
// | 2         | NSN      | 07-06-18 | Corrected MoveToAtt call
METHOD ReadDeclaration: BOOL
VAR_OUTPUT
	sXMLVersion		:STRING(8);		//The XML Version if found
	sXMLEncoding	:STRING(16);	//The encoding if found
	xXMLStandalone	:BOOL;			//True when standalone and false when not
END_VAR
VAR	
	StandAloneBuffer:STRING(3);		//Buffer for determining if standalone is yes or no
END_VAR
!__IMPLEMENTATION__!
IF Initialized THEN
	ReturnToStart();					//Cursor is set to the start
	IF MoveToString(pText:= ADR(XMLDecFirstCheck), dwAmount:= 4, xInTag := TRUE, xImediate := TRUE) THEN	//The declaration is checked against a string
		ReadDeclaration			:=		TRUE;
		IF MoveToAtt(pName:= ADR(XMLDecCheckVersion), xInLayer :=FALSE, xInTag :=TRUE) THEN		//Version attribute is found
			CopyAttVal(pCopyTo:= ADR(sXMLVersion), wCopyToMax:= 8, xEndString:= TRUE);				//Version attribute is copied
		END_IF
		ReturnToStart();					//Cursor is set to the start
		IF MoveToAtt(pName:= ADR(XMLDecCheckEncoding), xInLayer :=FALSE, xInTag :=TRUE) THEN	//Encoding attribute is found
			CopyAttVal(pCopyTo:= ADR(sXMLEncoding), wCopyToMax:= 16, xEndString:= TRUE);			//Encoding attribute is copied
		END_IF
		
		ReturnToStart();					//Cursor is set to the start
		IF MoveToAtt(pName:= ADR(XMLDecCheckStandalone), xInLayer :=FALSE, xInTag :=TRUE) THEN	//Standalone attribute is found
			CopyAttVal(pCopyTo:= ADR(StandAloneBuffer), wCopyToMax:= 3, xEndString:= TRUE);		//Standalone attribute is copied
			IF StandAloneBuffer = 'yes' OR StandAloneBuffer = 'Yes' OR StandAloneBuffer = 'YES' THEN	//Then it is converted to a bool
				xXMLStandalone	:=		TRUE;
			END_IF
		END_IF
		MoveToString(pText:= ADR(XMLEndTag), dwAmount:= 1, xInTag := FALSE, xImediate := FALSE);
		DeclarationEnd			:=		ADRCursor;
	END_IF
END_IF