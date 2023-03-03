{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function converts a string with the format yyyy-mm-dd-hh:mm:ss to a dt
//DT#2018-4-26-15:56:48 --> 'DT#2018-04-26-16:04:54' --> '2018-04-26-15:56:48'
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-09-20 | Creation
FUNCTION FU_StringYYYY_MM_DD_HH_MM_SSToDT: DT
VAR_INPUT
	str	:STRING(19);			//The input dt
END_VAR
!__IMPLEMENTATION__!
FU_StringYYYY_MM_DD_HH_MM_SSToDT	:=		TO_DT(FU_sConcat(s1:='DT#',s2:=str));			//The string components are extracted and combined
