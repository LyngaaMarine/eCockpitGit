{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method gets the next unique id
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 23-07-19 | Creation
METHOD incrementUpdateNumber
!__IMPLEMENTATION__!
S_moduleUpdate		:=		S_moduleUpdate + 1;
IF S_moduleUpdate = 0 OR S_moduleUpdate > 9999 THEN
	S_moduleUpdate	:=		1;
END_IF