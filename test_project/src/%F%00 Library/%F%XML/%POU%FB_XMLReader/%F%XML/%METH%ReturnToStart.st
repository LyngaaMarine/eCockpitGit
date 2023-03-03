{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method returns the cursor to the start of the xml file
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-06-18 | Creation
METHOD ReturnToStart
!__IMPLEMENTATION__!
IF Initialized THEN
	ADRCursor		:=		DeclarationEnd;
	TreeLevel		:=		0;
END_IF