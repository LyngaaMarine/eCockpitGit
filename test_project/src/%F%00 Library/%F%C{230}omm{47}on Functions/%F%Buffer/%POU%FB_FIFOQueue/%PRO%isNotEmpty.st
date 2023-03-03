{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROPERTY isNotEmpty : BOOL
!__GETTER__!
//Returns wether the buffer is not empty
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
VAR
END_VAR

!__IMPLEMENTATION__!
isNotEmpty		:=		S_amount > 0;
!__SETTER__!
