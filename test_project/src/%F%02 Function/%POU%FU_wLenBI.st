{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This function, returns the lenght of a string of any size
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation
// | 2         | NSN      | 10-12-18 | Made it based on FU_wLenAI
// | 3         | NSN      | 02-12-19 | Removed valid pointer check
FUNCTION FU_wLenBI : WORD
VAR_IN_OUT
	str			:STRING(1);			//Input String
END_VAR
VAR
	pStr		:POINTER TO BYTE;	//Address of the string
END_VAR
!__IMPLEMENTATION__!
pStr					:=		ADR(str);
WHILE pStr^ <> 0 DO
	FU_wLenBI			:=		FU_wLenBI + 1;
	pStr				:=		pStr + 1;
END_WHILE