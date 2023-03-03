{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function extracts the time and date from a dt variable and outputs it as a string with the format hh:mm:ss yy-mm-dd
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-04-18 | Creation
FUNCTION FU_sDTToStringHH_MM_SS_YY_MM_DD: STRING(17)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
!__IMPLEMENTATION__!
dtConv									:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringHH_MM_SS_YY_MM_DD			:=		FU_sConcat(FU_sMID(dtConv,8,15),FU_sConcat(' ',FU_sMID(dtConv,8,6)));	//The string components are extracted
