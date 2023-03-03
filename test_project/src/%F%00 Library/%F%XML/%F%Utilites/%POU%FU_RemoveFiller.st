{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function removes the filler from a string, it does it by replacing the first found character corresponding to a null
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 25-01-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_RemoveFiller
VAR_INPUT
	StrAdr		:POINTER TO BYTE;	//Address of string to remove filler from
	Size		:WORD;				//Size of string
	FillerChar	:BYTE;				//Character code used for filler
END_VAR
!__IMPLEMENTATION__!
WHILE Size > 0 DO		//Runs through string
	IF StrAdr^ = FillerChar THEN		//When fillerchar is found
		StrAdr^	:=		0;				//First fillerchar is replace by null
		EXIT;							//Loop is finished
	END_IF
	IF Size > 1 THEN					//Addresses are only incremented when needed
		StrAdr	:=		StrAdr + 1;
	END_IF
	Size		:=		Size - 1;
END_WHILE