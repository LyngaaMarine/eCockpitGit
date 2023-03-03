//This function decodes a base64 string to a normal string or byte array
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
FUNCTION BASE64Decode : BOOL
VAR_INPUT
	inStr		:POINTER TO BYTE;
	outStr		:POINTER TO BYTE;		//Out string must be at least 3/4 as long as input string and also a multiple of 4
END_VAR
VAR
	inStrNext	:POINTER TO BYTE := inStr + 1;
	baseBuffer	:BYTE;
END_VAR
VAR CONSTANT
	base64Vars	:ARRAY[43..122] OF BYTE := [62,0,0,0,63,52,53,54,55,56,57,58,59,60,61,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,0,0,0,0,0,0,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51];
END_VAR

(*%!%__DELIMITER__%!%*)
WHILE inStr^ <> 0 AND inStrNext^ <> 0 DO
	baseBuffer				:=		SHL(base64Vars[inStr^],2) OR SHR(base64Vars[inStrNext^],4);
	outStr^					:=		baseBuffer;
	inStr					:=		inStr + 1;
	inStrNext				:=		inStr + 1;
	outStr					:=		outStr + 1;
	IF inStr^ <> 0 AND inStrNext^ <> 0 THEN
		baseBuffer			:=		SHL(base64Vars[inStr^],4) OR SHR(base64Vars[inStrNext^],2);
		outStr^				:=		baseBuffer;
		inStr				:=		inStr + 1;
		inStrNext			:=		inStr + 1;
		outStr				:=		outStr + 1;
		IF inStr^ <> 0 AND inStrNext^ <> 0 THEN
			baseBuffer		:=		SHL(base64Vars[inStr^],6) OR base64Vars[inStrNext^];
			outStr^			:=		baseBuffer;
			inStr			:=		inStr + 2;
			inStrNext		:=		inStr + 1;
			outStr			:=		outStr + 1;
		END_IF
	END_IF
END_WHILE