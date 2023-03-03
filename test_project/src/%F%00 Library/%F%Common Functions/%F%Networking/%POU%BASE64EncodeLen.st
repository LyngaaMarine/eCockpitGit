//This function encodes a normal string or byte array of fixed lenght to a base 64 string
//This version exists to process strings with zeros in them
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
FUNCTION BASE64EncodeLen : BOOL
VAR_INPUT
	inStr		:POINTER TO BYTE;		//Input string
	inLen		:WORD;					//Lenght of input string
	outStr		:POINTER TO BYTE;		//Out string must be at least 1/3 longer than input string and also a multiple of 4
END_VAR
VAR
	inStrLast	:POINTER TO BYTE := inStr;
END_VAR
VAR CONSTANT
	base64Vars	:ARRAY[0..63] OF BYTE := [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,48,49,50,51,52,53,54,55,56,57,43,47];
END_VAR

(*%!%__DELIMITER__%!%*)
WHILE inLen > 0 DO
	outStr^					:=		base64Vars[SHR(inStr^,2)];
	inStrLast				:=		inStr;
	inStr					:=		inStr + 1;
	outStr					:=		outStr + 1;
	inLen					:=		inLen - 1;
	IF inLen = 0 THEN
		outStr^				:=		base64Vars[SHR(0,4) OR SHL(inStrLast^,4) AND 63];
		outStr				:=		outStr + 1;
		outStr^				:=		EASCII.Equal;
		outStr				:=		outStr + 1;
		outStr^				:=		EASCII.Equal;
	ELSE
		outStr^				:=		base64Vars[SHR(inStr^,4) OR SHL(inStrLast^,4) AND 63];
		inStrLast			:=		inStr;
		outStr				:=		outStr + 1;
		inStr				:=		inStr + 1;
		IF inLen = 1 THEN
			outStr^			:=		base64Vars[SHR(0,6) OR SHL(inStrLast^,2) AND 63];
			outStr			:=		outStr + 1;
			outStr^			:=		EASCII.Equal;
			inLen			:=		inLen - 1;
		ELSE
			outStr^			:=		base64Vars[SHR(inStr^,6) OR SHL(inStrLast^,2) AND 63];
			outStr			:=		outStr + 1;
			inLen			:=		inLen - 1;
			IF inLen = 0 THEN
				outStr^		:=		EASCII.Equal;
			ELSE
				outStr^		:=		base64Vars[inStr^ AND 63];
				outStr		:=		outStr + 1;
				inStr		:=		inStr + 1;
				inLen		:=		inLen - 1;
			END_IF	
		END_IF
	END_IF
END_WHILE
outStr						:=		outStr + 1;
outStr^						:=		0;
