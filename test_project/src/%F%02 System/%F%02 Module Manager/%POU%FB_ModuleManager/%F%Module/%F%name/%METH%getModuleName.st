//Method for getting the name of a module with placeholders filled
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 14-12-20 | Creation
METHOD getModuleName : AModuleName
VAR_INPUT
	module			:POINTER TO FB_Module;
	layer			:BYTE;
END_VAR
VAR
	namePos			:BYTE;
	nameBuffPos		:BYTE;
	nameBuff		:AModuleName;
	textBuff		:AModuleName;
	textPos			:BYTE;
	checker			:POINTER TO DWORD;
	checker2		:POINTER TO WORD;
	modBuff			:POINTER TO FB_Module;
	offSet			:BYTE := 3;
	utfFix			:POINTER TO EASCII;
END_VAR
//$ = 0010 0100
//a = 0110 0001
//b = 0110 0010
//d = 0110 0100
//e = 0110 0101
//i = 0110 1001
//n = 0110 1110
//p = 0111 0000
//r = 0111 0010
//s = 0111 0011
//t = 0111 0100
//u = 0111 0101
//x = 0111 1000

// $pat =    0111 0100   0110 0001   0111 0000   0010 0100
// $par =    0111 0010   0110 0001   0111 0000   0010 0100
// $sub =    0110 0010   0111 0101   0111 0011   0010 0100
// $idx =    0111 1000   0110 0100   0110 1001   0010 0100
// $uid =    0110 0100   0110 1001   0111 0101   0010 0100
// $des =    0111 0011   0110 0101   0110 0100   0010 0100
// $uns =    0111 0011   0110 1110   0111 0101   0010 0100

// $ir  =    0111 0010   0110 1001
// $it  =    0111 0100   0110 1001
// $id  =    0110 0100   0110 1001

(*%!%__DELIMITER__%!%*)
IF module^._name <> 0 THEN
	nameBuff								:=		module^._name^;
END_IF
IF layer < 3 THEN
	FOR namePos := 0 TO TO_BYTE(SIZEOF(AModuleName) - 1) DO
		CASE nameBuff[nameBuffPos] OF
			EASCII.Null:
				getModuleName[namePos]		:=		0;
				RETURN;
			EASCII.Dollar:
				checker						:=		ADR(nameBuff[nameBuffPos]);
				CASE checker^ OF
					2#01110100011000010111000000100100,2#01110010011000010111000000100100: // $pat, $par
						textBuff			:=		THIS^.getModuleName(module:=module^._parent,layer:=layer+1); 
					2#01100010011101010111001100100100: // $sub
						textBuff			:=		TO_STRING(_SID); 
					2#01100100011010010111010100100100: // $uid
						textBuff			:=		TO_STRING(_UID);
					2#01110011011001010110010000100100: // $des
						textBuff			:=		SYS_designator;
					2#01110011011011100111010100100100: // $uns
						textBuff			:=		getModuleUnit(module:=THIS,layer:=layer);
				ELSE
					checker2				:=		ADR(nameBuff[nameBuffPos + 1]);
					CASE checker2^ OF
						2#0111001001101001,2#0111010001101001: // $ir, $it
							modBuff			:=		moduleNameDecodeDollarUID(first:=checker2 + 2,offSet=>offSet);
							IF modBuff <> 0 THEN
								textBuff	:=		THIS^.getModuleName(module:=modBuff,layer:=layer+1);; 
							END_IF
						2#0110010001101001: // $id
							modBuff			:=		moduleNameDecodeDollarUID(first:=checker2 + 2,offSet=>offSet);
							IF modBuff <> 0 THEN
								textBuff	:=		modBuff^.SYS_designator;
							END_IF
					END_CASE
				END_CASE
				FOR textPos := 0 TO TO_BYTE(SIZEOF(AModuleName) - 1) DO
					IF namePos = SIZEOF(AModuleName) - 1 THEN
						EXIT;
					END_IF
					IF textBuff[textPos] = 0 THEN
						namePos				:=		namePos - 1;
						EXIT;
					END_IF
					getModuleName[namePos]	:=		textBuff[textPos];
					namePos					:=		namePos + 1;
				END_FOR
			nameBuffPos						:=		nameBuffPos + offSet;
		ELSE
			getModuleName[namePos]			:=		nameBuff[nameBuffPos];
		END_CASE
		IF namePos = SIZEOF(AModuleName) - 1 THEN
			EXIT;
		END_IF
		nameBuffPos							:=		nameBuffPos + 1;
	END_FOR
		CASE FU_CheckUTF8(strStart:=ADR(getModuleName),char:=ADR(getModuleName[namePos - 1]), start=>utfFix) OF
		1,2,4:	utfFix^						:=		0;
	END_CASE
	getModuleName[namePos]					:=		0;
END_IF