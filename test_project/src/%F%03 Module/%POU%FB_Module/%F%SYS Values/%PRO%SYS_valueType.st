{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Property for getting which format the value of the module is
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-11-20 | Creation
PROPERTY SYS_valueType : EValueType

!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
SYS_valueType		:=		EValueType.none;
!__SETTER__!
