//This function, converts passed seconds to minutes, hours, days, weeks, years, and only outputs the two biggest active time formats
//example 249 = Minutes: 4 Seconds: 9, 529385 = Days: 6 Hours: 3
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 09-01-18 | Updated to new format
// | 1         | NSN      | 13-06-18 | Updated names and types
FUNCTION FU_sCountUpDateTime : STRING(24)
VAR_INPUT
	dwSeconds	:DWORD;		//Input seconds
END_VAR
VAR
	Remains		:DWORD;		//Date time converted to seconds
	Buffer1		:DWORD;		//Buffer for first value
	Buffer2		:DWORD;		//Buffer for second value
END_VAR
(*%!%__DELIMITER__%!%*)
Remains 							:=		dwSeconds;
IF Remains < 604799 THEN
	IF Remains < 86401 THEN
		IF Remains < 3601 THEN
			IF Remains < 61 THEN	//This calculates the seconds
				Buffer1				:=		Remains;
				FU_sCountUpDateTime	:=		FU_sConcat('Seconds: ', TO_STRING(Buffer1));			
			ELSE					//This calculates the minutes and seconds
				Buffer1				:=		Remains / 60;
				Remains				:=		(Remains - (Buffer1 * 60));
				Buffer2				:=		Remains;
				FU_sCountUpDateTime	:=		FU_sConcat('Minutes: ', TO_STRING(Buffer1));
				FU_sCountUpDateTime	:=		FU_sConcat(FU_sCountUpDateTime, ' Seconds: ');
				FU_sCountUpDateTime	:=		FU_sConcat(FU_sCountUpDateTime, TO_STRING(Buffer2));	
			END_IF	
		ELSE						//This calculates the hours and minutes
			Buffer1					:=		Remains / 3600;
			Remains					:=		(Remains - (Buffer1 * 3600));
			Buffer2					:=		Remains / 60;
			FU_sCountUpDateTime		:=		FU_sConcat('Hours: ', TO_STRING(Buffer1));
			FU_sCountUpDateTime		:=		FU_sConcat(FU_sCountUpDateTime, ' Minutes: ');
			FU_sCountUpDateTime		:=		FU_sConcat(FU_sCountUpDateTime, TO_STRING(Buffer2));
		END_IF
	ELSE							//This calculates the days and hours
		Buffer1						:=		Remains / 86400;
		Remains						:=		(Remains - (Buffer1 * 86400));
		Buffer2						:=		Remains / 3600;
		FU_sCountUpDateTime			:=		FU_sConcat('Days: ', TO_STRING(Buffer1));
		FU_sCountUpDateTime			:=		FU_sConcat(FU_sCountUpDateTime, ' Hours: ');
		FU_sCountUpDateTime			:=		FU_sConcat(FU_sCountUpDateTime, TO_STRING(Buffer2));
	END_IF
ELSE
	Buffer1							:=		Remains / 604800;
	Remains							:=		(Remains - (Buffer1 * 604800));
	Buffer2							:=		Remains / 86400;
	FU_sCountUpDateTime				:=		FU_sConcat('Weeks: ', TO_STRING(Buffer1));
	FU_sCountUpDateTime				:=		FU_sConcat(FU_sCountUpDateTime, ' Days: ');
	FU_sCountUpDateTime				:=		FU_sConcat(FU_sCountUpDateTime, TO_STRING(Buffer2));	
END_IF