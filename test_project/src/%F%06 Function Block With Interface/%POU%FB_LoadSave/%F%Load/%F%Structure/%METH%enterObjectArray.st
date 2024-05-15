{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method enters the last found object and sets it as the current object for searching
//Returns none, when there are no more keys
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD enterObjectArray :BOOL

!__IMPLEMENTATION__!
enterObjectArray	:=		reader.enterObjectArray();