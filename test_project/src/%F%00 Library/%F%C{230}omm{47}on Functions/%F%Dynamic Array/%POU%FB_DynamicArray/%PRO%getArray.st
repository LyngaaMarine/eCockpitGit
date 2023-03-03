{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROPERTY getArray : POINTER TO ARRAY[0..99] OF BYTE
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
getArray		:=		S_array^;
!__SETTER__!
