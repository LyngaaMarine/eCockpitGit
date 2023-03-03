//THIS functions copies the content OF an array of bytes into a string
//It must be used in the following way
//FU_ByteArrayToString(pArray:= ADR(ByteArray), usiArrSize:= SIZEOF(ByteArray), pString:= ADR(StringVar), usiStrSize:= SIZEOF(StringVar));
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 10-08-17 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_ByteArrayToString : BOOL
VAR_INPUT
	pArray			:POINTER TO BYTE;			//Address of Byte array
	usiArrSize		:UINT;						//Size of byte array
	pString			:POINTER TO BYTE;			//Address to the string
	usiStrSize		:UINT;						//Size of String	
END_VAR
VAR
	SmallestSize		:INT;						//Size of the smallest size
END_VAR
(*%!%__DELIMITER__%!%*)
//Smallest size is found, to make sure the function doesn't write to addresses outside the array
IF usiStrSize-1 < usiArrSize THEN
	SmallestSize	:=		TO_INT(usiStrSize-1);
ELSE
	SmallestSize	:=		TO_INT(usiArrSize);
END_IF
//The data from the string is copied from the string to the byte array
WHILE SmallestSize > 0 DO
	SmallestSize	:=		SmallestSize - 1;
	IF pArray^ = 0 THEN
		pString^	:=		0;
		RETURN;
	END_IF
	pString^		:=		pArray^;
	//This increments the addresses by 1
	pString			:=		pString + 1;
	pArray			:=		pArray + 1;
END_WHILE
