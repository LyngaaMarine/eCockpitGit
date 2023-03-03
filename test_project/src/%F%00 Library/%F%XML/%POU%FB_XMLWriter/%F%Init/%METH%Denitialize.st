{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-01-18 | Creation
// | 2         | NSN      | 21-06-18 | Added missing values, needed to be reset
METHOD Denitialize
VAR
	MethodID		:BYTE := 11;			//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized THEN
	//Closes up remaining structs
	WHILE TreeLevel > 0 DO
		AddStructEnd();
	END_WHILE
	//Initialisation is done
	Initialized				:=		FALSE;
	//Values are reset
	FileBufferADR			:=		0;
	FileBufferMaxADR		:=		0;
	FileBufferADROG			:=		0;
	AttPosBuffer			:=		0;
	LastMethod				:=		0;
	FOR FOR1 := 0 TO 254 DO
		TreeNames[FOR1]		:=		0;
	END_FOR
	EOBReached				:=		FALSE;
	BufferBroken			:=		FALSE;
	//Last Method is recorded
	LastMethod				:=		MethodID;
END_IF
