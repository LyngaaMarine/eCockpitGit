{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//Returns the current level the cursor is at
PROPERTY amountLevels : BYTE
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
amountLevels	:=		treeLevel;
!__SETTER__!
