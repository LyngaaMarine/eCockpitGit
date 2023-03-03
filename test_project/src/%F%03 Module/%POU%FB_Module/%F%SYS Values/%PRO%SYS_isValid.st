{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Property for checking if module value is valid, for example if value comes over the network and network connection is down.
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 12-12-20 | Creation
PROPERTY SYS_isValid : EValueValidity
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
SYS_isValid		:=		EValueValidity.valid;
!__SETTER__!
