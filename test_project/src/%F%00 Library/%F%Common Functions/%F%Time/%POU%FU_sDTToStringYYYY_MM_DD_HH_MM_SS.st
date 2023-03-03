//This function extracts the time and date from a dt variable and outputs it as a string with the format yyyy-mm-dd hh:mm:ss
//DT#2018-4-26-15:56:48 --> 'DT#2018-04-26-16:04:54' --> '2018-04-26-15:56:48'
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 25-04-18 | Creation
// | 1         | NSN      | 16-09-20 | Changed 2018-04-26 15:56:48 to 2018-04-26-15:56:48 to reduce cpu usage
FUNCTION FU_sDTToStringYYYY_MM_DD_HH_MM_SS: STRING(19)
VAR
	dtConv		:STRING(22);	//dt converted to a string
END_VAR
VAR_INPUT
	dtDateTime	:DT;			//The input dt
END_VAR
(*%!%__DELIMITER__%!%*)
dtConv								:=		TO_STRING(dtDateTime);		//The dt is converted to a string
FU_sDTToStringYYYY_MM_DD_HH_MM_SS	:=		FU_sMidBI(sStr:=dtConv,wLen:=19,wPos:=4);			//The string components are extracted and combined
