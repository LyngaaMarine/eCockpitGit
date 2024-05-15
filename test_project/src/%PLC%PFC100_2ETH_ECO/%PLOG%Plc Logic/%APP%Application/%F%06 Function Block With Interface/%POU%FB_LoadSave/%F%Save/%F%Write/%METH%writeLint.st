{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeLint
VAR_INPUT
	value			:LINT;
END_VAR
!__IMPLEMENTATION__!
writer.writeLint(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tLINT);