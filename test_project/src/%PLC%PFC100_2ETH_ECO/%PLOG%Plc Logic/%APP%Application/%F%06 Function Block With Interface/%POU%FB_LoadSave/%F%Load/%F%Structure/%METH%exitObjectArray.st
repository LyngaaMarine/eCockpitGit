{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method exits the current object or array
//Returns none, when there are no more keys
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD exitObjectArray : BOOL

!__IMPLEMENTATION__!
exitObjectArray		:=		reader.exitObjectArray();