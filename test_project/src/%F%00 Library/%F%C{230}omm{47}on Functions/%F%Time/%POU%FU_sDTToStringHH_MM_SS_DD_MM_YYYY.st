{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function extracts the time and date from a dt variable and outputs it as a string with the format hh:mm:ss dd-mm-yyyy
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-06-18 | Creation
FUNCTION FU_sDTToStringHH_MM_SS_DD_MM_YYYY: STRING(19)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
!__IMPLEMENTATION__!
dtConv									:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringHH_MM_SS_DD_MM_YYYY		:=		
FU_sConcat(
FU_sMID(dtConv,8,15)
,
FU_sConcat(' ',FU_sConcat(FU_sMID(dtConv,2,12),FU_sConcat(FU_sMID(dtConv,4,8),FU_sMID(dtConv,4,4))))
);