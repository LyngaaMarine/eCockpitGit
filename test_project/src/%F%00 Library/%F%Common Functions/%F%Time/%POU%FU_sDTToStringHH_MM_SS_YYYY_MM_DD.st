//This function extracts the time and date from a dt variable and outputs it as a string with the format hh:mm:ss yyyy-mm-dd
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-04-18 | Creation
FUNCTION FU_sDTToStringHH_MM_SS_YYYY_MM_DD: STRING(19)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
(*%!%__DELIMITER__%!%*)
dtConv									:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringHH_MM_SS_YYYY_MM_DD		:=		FU_sConcat(FU_sMID(dtConv,8,15),FU_sConcat(' ',FU_sMID(dtConv,10,4)));	//The string components are extracted
