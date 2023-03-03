{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROPERTY isFull : BOOL
!__GETTER__!
//Retruns wether the buffer is full
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
VAR
END_VAR

!__IMPLEMENTATION__!
isFull		:=		S_amount >= S_bufferSize;
!__SETTER__!
