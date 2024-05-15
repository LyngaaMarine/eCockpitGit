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
METHOD writeDint
VAR_INPUT
	value			:DINT;
END_VAR
!__IMPLEMENTATION__!
writer.writeDint(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tDINT);