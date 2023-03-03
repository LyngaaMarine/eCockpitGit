{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Determines wether logging should be performed on the module
//True means no loggings
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 06-12-20 | Creation
PROPERTY SYS_dontLog : BOOL
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
SYS_dontLog		:=		FALSE;
!__SETTER__!
