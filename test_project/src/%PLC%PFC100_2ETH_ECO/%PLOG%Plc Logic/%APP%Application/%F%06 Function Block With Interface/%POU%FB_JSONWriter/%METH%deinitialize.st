{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD deinitialize

!__IMPLEMENTATION__!
IF ready THEN
	//Closes up remaining structs
	WHILE treeLevel > 0 DO
		CASE treeTypes[treeLevel] OF
			EStructType.object,EStructType.tArray:
				structEnd();
		END_CASE
	END_WHILE
	bufferPosition			:=		bufferPosition - 1;
	bufferPosition^			:=		EASCII.Null;
	//Initialisation is done
	ready					:=		FALSE;
	//Values are reset
	bufferMaxADR			:=		0;
	inArray					:=		FALSE;
	inObject				:=		FALSE;
	singleVal				:=		FALSE;
	lastComma				:=		0;
	bottomTypeInt			:=		EStructType.none;
	treeLevel				:=		0;
END_IF
