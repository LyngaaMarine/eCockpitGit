{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This packs an SResult into a struct
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 05-11-20 | Creation
FUNCTION FU_SLMResultFromParts : SLMResult;
VAR_INPUT
	success		:BOOL := TRUE;
	code		:WORD := 1;
	reason		:POINTER TO STRING(1000);
END_VAR
!__IMPLEMENTATION__!
FU_SLMResultFromParts.success		:=		success;
FU_SLMResultFromParts.code			:=		code;
FU_SLMResultFromParts.reason		:=		reason;