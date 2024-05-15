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
// | 1         | NSN      | 16-05-21 | Creation
METHOD writeDword
VAR_INPUT
	value			:DWORD;
END_VAR
!__IMPLEMENTATION__!
writer.writeDword(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tDWORD);