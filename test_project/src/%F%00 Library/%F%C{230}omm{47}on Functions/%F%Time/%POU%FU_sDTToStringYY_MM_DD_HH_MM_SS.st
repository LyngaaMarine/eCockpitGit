{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function extracts the time and date from a dt variable and outputs it as a string with the format yy-mm-dd hh:mm:ss
//DT#2018-4-26-15:56:48 --> 'DT#2018-04-26-16:04:54' --> '18-04-26 15:56:48'
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 25-04-18 | Creation
FUNCTION FU_sDTToStringYY_MM_DD_HH_MM_SS: STRING(17)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
!__IMPLEMENTATION__!
dtConv							:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringYY_MM_DD_HH_MM_SS	:=		FU_sConcat(FU_sMID(dtConv,8,6),FU_sConcat(' ',FU_sMID(dtConv,8,15)));			//The string components are extracted and combined
