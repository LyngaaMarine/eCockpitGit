{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method initializes the reader with the correct values
//It returns ok when the inputs are correct
//It returns missingvars, if one of the variables are wrong
//It returns alreadyInitialized if the reader is already in use
//The jsonType output is set to the type of the buttom value of the json file
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-07-20 | Creation
METHOD initialize : SLMResult
VAR_INPUT
	buffer			:POINTER TO EASCII;	//The address of the file buffer
	bufferSize		:DWORD;				//The size of the file buffer
END_VAR
VAR_OUTPUT
	structType		:EStructType;
END_VAR
VAR
	valuePosBuffer	:POINTER TO EASCII;
END_VAR
!__IMPLEMENTATION__!
IF buffer = 0 OR bufferSize = 0 THEN
	initialize.success		:=		FALSE;
	initialize.code			:=		ERCodes.FB_JSONReader_initialize;
	initialize.reason		:=		GTErrors.EmissingInputVars;
	RETURN;
END_IF

IF ready THEN
	initialize.success		:=		FALSE;
	initialize.code			:=		ERCodes.FB_JSONReader_initialize;
	initialize.reason		:=		GTErrors.EresourceInUse;
	RETURN;
END_IF

bufferADROrg				:=		buffer;					//Original adress is saved internally
bufferADRMax				:=		buffer + bufferSize;	//End adress is saved internally
structType					:=		getType(valueFirstByte:=bufferADROrg,valuePos=>valuePosBuffer);	//Type of buttom value is read
IF structType <> EStructType.none THEN
	buttomType				:=		structType;
	CASE structType OF
		EStructType.object,EStructType.tArray:
			treeLevel		:=		treeLevel + 1;
			treeSelected[treeLevel]			:=		valuePosBuffer;
			treeSelectedTypes[treeLevel]	:=		structType;
			treeSelectedArrayProg[treeLevel]:=		0;
	ELSE
		lastValueStart		:=		valuePosBuffer;
		lastValueType		:=		structType;
	END_CASE
	ready					:=		TRUE;
	RETURN;
END_IF
