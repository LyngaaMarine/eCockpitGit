{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method finds the next value in an array
//Returns none, when there are no more entries
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD nextArray : EStructType

!__IMPLEMENTATION__!
nextArray		:=		reader.nextArray();