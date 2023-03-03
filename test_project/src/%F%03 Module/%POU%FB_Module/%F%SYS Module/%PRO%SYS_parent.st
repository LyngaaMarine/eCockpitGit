{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Property returning pointer to parent of object
//Modules within a folder module will return folders parent
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 06-12-20 | Creation
PROPERTY SYS_parent : POINTER TO FB_Module
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
SYS_parent		:=		_parent;
!__SETTER__!
