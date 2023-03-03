{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method returns the address of the cursor
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD GetPosAddress : POINTER TO BYTE
!__IMPLEMENTATION__!
IF Initialized THEN
	GetPosAddress		:=		ADRCursor;
END_IF