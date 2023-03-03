//This method decodes a json struct into an action paramter buffer
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-08-21 | Creation
//If any data is missing from the json struct is must be return in the result struct
//Length of parameters in dints(4bytes) must be returned
METHOD actionParamDecoder : SLMResult
VAR_IN_OUT
	actionParams	:AActionParams;		//The action parameters to edit
END_VAR
VAR_INPUT
	actionID		:WORD;		//Id for action, the same id can be used on different modules 40000-50000 are reserved for system
	reader			:ITF_StructReaderBase;	
END_VAR
VAR_OUTPUT
	lenght			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
WHILE reader.nextArray() <> EStructType.none DO
	CASE actionID OF
		0: 
			CASE reader.arrayIndex OF
				0:	actionParams[0].bBOOL		:=		reader.readBool();
			END_CASE
	END_CASE
END_WHILE

