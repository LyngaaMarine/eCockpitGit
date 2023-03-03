{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function extracts the time and date from a dt variable and outputs it as a string with the format hh:mm:ss yy-mm-dd
//DT#2018-04-26-15:56:48
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-04-18 | Creation
FUNCTION FU_sDTToStringSS_MM_HH_DD_MM_YY: STRING(17)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
!__IMPLEMENTATION__!
dtConv									:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringSS_MM_HH_DD_MM_YY			:=		
FU_sConcat(

FU_sConcat(FU_sMID(dtConv,2,21),FU_sConcat(FU_sMID(dtConv,4,17),FU_sMID(dtConv,2,15)))

,

FU_sConcat(' ',FU_sConcat(FU_sMID(dtConv,2,12),FU_sConcat(FU_sMID(dtConv,4,8),FU_sMID(dtConv,2,6))))

);	//The string components are extracted