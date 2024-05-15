{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
PROPERTY selectedType : EStructType
!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
IF treeLevel > 0 THEN
	selectedType		:=		treeSelectedTypes[treeLevel];
ELSE
	selectedType		:=		buttomType;
END_IF

!__SETTER__!
