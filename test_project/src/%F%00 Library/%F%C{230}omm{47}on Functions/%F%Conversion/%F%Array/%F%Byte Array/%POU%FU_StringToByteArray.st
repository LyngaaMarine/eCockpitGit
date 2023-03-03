{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions copies the content of a string into an array of bytes
//It must be used in the following way
//FU_StringToByteArray(pString:= ADR(StringVar), usiStrSize:= SIZEOF(StringVar), pArray:= ADR(ByteArray), usiArrSize:= SIZEOF(ByteArray));
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 10-08-17 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_StringToByteArray : BOOL
VAR_INPUT
	pString			:POINTER TO BYTE;			//Address to the string
	usiStrSize		:UINT;						//Size of String	
	pArray			:POINTER TO BYTE;			//Address of Byte array
	usiArrSize		:UINT;						//Size of byte array
END_VAR
VAR
	SmallestSize		:INT;						//Size of the smallest size
END_VAR
!__IMPLEMENTATION__!
//Smallest size is found, to make sure the function doesn't write to addresses outside the array
IF usiStrSize < usiArrSize THEN
	SmallestSize	:=		TO_INT(usiStrSize);
ELSE
	SmallestSize	:=		TO_INT(usiArrSize);
END_IF
//The data from the string is copied from the string to the byte array
WHILE SmallestSize > 0 DO
	SmallestSize	:=		SmallestSize - 1;
	//This looks for the end of string value
	IF pString^ = 0 THEN
		pArray^		:=		0;
	ELSE
		//This copies the data if the string is not done
		pArray^		:=		pString^;
		pString		:=		pString + 1;
	END_IF

	//This increments the addresses by 1
	pArray			:=		pArray + 1;
END_WHILE
