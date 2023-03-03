{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method deinitializes the reader, resetting all internal values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-06-18 | Creation
// | 2         | NSN      | 21-06-18 | Added missing values, needed to be reset
METHOD Deinitialize
VAR
	FOR1					:BYTE;
END_VAR
!__IMPLEMENTATION__!
IF Initialized THEN
	//Values are reset
	ADRCursor					:=		0;
	FileBufferMaxADR			:=		0;
	FileBufferADROG				:=		0;
	FileBufferSize				:=		0;
	FileBufferSize				:=		0;
	AttDataBuffer				:=		0;
	TagDataBuffer				:=		0;
	TreeLevel					:=		0;
	FOR FOR1 := 0 TO 254 DO
		StructPositions[FOR1]	:=		0;
	END_FOR
	StructPosOffset				:=		0;
	StructPosOffset2			:=		1;
	DeclarationEnd				:=		0;
	Initialized					:=		FALSE;	
END_IF
