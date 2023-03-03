//This function extracts the time and date from a dt variable and outputs it as a string with the format hh:mm:ss
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 14-06-18 | Creation
FUNCTION FU_sDTToStringHH_MM_SS: STRING(8)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
(*%!%__DELIMITER__%!%*)
dtConv									:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringHH_MM_SS					:=		FU_sMID(dtConv,8,15);	//The string components are extracted
