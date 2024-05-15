{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This function block can has a string value
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | xx-xx-xx | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION_BLOCK FB_MD5
VAR_INPUT
	sSecret						:STRING;
END_VAR
VAR_OUTPUT
	sMD5						:STRING;
END_VAR
VAR
	abDigest					:ARRAY[0..15] OF BYTE;		//MD5 digest
END_VAR
VAR CONSTANT
	udiNumberOfBytePerSegment	:UDINT := 64;	//higher value -> more time for calculation per PLC-cycle and less PLC cycles are needed for calculation
END_VAR
VAR
	pMemoryBlock				:DWORD; 	//address of memory block
	udiNumberOfBytes			:UDINT; 	//number of bytes of memory block
	wState						:UINT; 		//Statemashine
	udiNumberOfBytesTotal		:UDINT;
	uiLoop						:UINT;
	udiNumberOfBytesUpdated		:UDINT;
	uiNumberOfSegments			:UINT;
//Context
	adwState					:ARRAY[0..3] OF DWORD;
	adwCount					:ARRAY[0..1] OF DWORD;
	abyBuffer					:ARRAY[0..63] OF BYTE;
//Update
	pInput						:POINTER TO BYTE;
	udiLength					:UDINT;
	udiIndex					:UDINT;
	udiPartLen					:UDINT;
	udiInputOffset				:UDINT;
//Final
	Index						:UDINT;
	PadLen						:UDINT;
	abBits						:ARRAY[0..7] OF BYTE;
	abPadding					:ARRAY[0..63] OF BYTE := [16#80];
//Helpers
	bHelp						:BYTE;			//used to calculate the digest
	sHelp						:STRING(2); 	//used to calculate the digest 
	pabHelp						:POINTER TO ARRAY [0..255] OF BYTE; //used to add the EndOfString (16#00)
	i							:INT;
END_VAR

!__IMPLEMENTATION__!
pInput							:=		ADR(sSecret);
udiNumberOfBytesTotal			:=		TO_UDINT(FU_wLenBI(str:=sSecret));
udiNumberOfBytesUpdated			:=		0;
uiNumberOfSegments				:=		0;
adwState[0]						:=		16#67452301;
adwState[1]						:=		16#EFCDAB89;
adwState[2]						:=		16#98BADCFE;
adwState[3]						:=		16#10325476;
adwCount[0]						:=		0;
adwCount[1]						:=		0;
//clear context buffer
FOR uiLoop := 0 TO 63 DO
	abyBuffer[uiLoop]			:=		0 ;
END_FOR
wState							:=		10;

WHILE wState = 10 DO
	IF udiNumberOfBytesUpdated + udiNumberOfBytePerSegment < udiNumberOfBytesTotal THEN
		udiLength				:=		udiNumberOfBytePerSegment;
	ELSE
		udiLength				:=		udiNumberOfBytesTotal - udiNumberOfBytesUpdated;
		wState					:=		20 ;
	END_IF
	
//MD5 block update operation. Continues an MD5 message-digest operation, processing another message block, and updating the context

	//compute number of bytes MOD 64
	udiIndex					:=		SHR(adwCount[0], 3) AND 16#3F;
	//update number of bits
	adwCount[0]					:=		adwCount[0] + SHL(udiLength,3) ;
	IF adwCount[0] < SHL(udiLength, 3) THEN
		adwCount[1]				:=		adwCount[1] + 1 ;
	END_IF
	adwCount[1]					:=		adwCount[1] + SHR(udiLength, 29);
	
	udiPartLen					:=		UDINT#64 - udiIndex ;
	
	//transform as many times as possible
	IF udiLength >= udiPartLen THEN
		MD5_Move(pInput, ADR(abyBuffer[udiIndex]), TO_UINT(udiPartLen));
		MD5_Transform(ADR(adwState),ADR(abyBuffer));
		udiInputOffset			:=		udiPartLen;
		WHILE udiInputOffset + 63 < udiLength DO
			MD5_Transform(ADR(adwState), pInput+udiInputOffset);
			udiInputOffset		:=		udiInputOffset + 64 ;
		END_WHILE ;
		udiIndex				:=		0;
	ELSE
		udiInputOffset			:=		0 ;
	END_IF
	
	//buffer remaining input
	MD5_Move(pInput+udiInputOffset,ADR(abyBuffer[udiIndex]), TO_UINT(udiLength - udiInputOffset));	
	
	udiNumberOfBytesUpdated		:=		udiNumberOfBytesUpdated + udiLength ;
	uiNumberOfSegments			:=		uiNumberOfSegments + 1;
	pInput						:=		pInput + udiLength;
END_WHILE

//MD5 finalization. Ends an MD5 message-digest operation and writing the the message digest
MD5_Move(ADR(adwCount),ADR(abBits),8);

Index							:=		SHR(adwCount[0], 3) AND 16#3F;
IF Index < 56 THEN
	PadLen						:=		56 - Index ;
ELSE
	PadLen						:=		120 - Index;
END_IF

pInput							:=		ADR(abPadding) ;
udiLength						:=		PadLen ;
//MD5 block update operation. Continues an MD5 message-digest operation, processing another message block, and updating the context.

(* compute number of bytes MOD 64 *)
udiIndex						:=		SHR(adwCount[0], 3) AND 16#3F;
(* update number of bits *)
adwCount[0]						:=		adwCount[0] + SHL(udiLength,3) ;
IF adwCount[0] < SHL(udiLength, 3) THEN
	adwCount[1]					:=		adwCount[1] + 1 ;
END_IF
adwCount[1]						:=		adwCount[1] + SHR(udiLength, 29);

udiPartLen						:=		UDINT#64 - udiIndex ;

//transform as many times as possible.
IF udiLength >= udiPartLen THEN
	MD5_Move(pInput, ADR(abyBuffer[udiIndex]), TO_UINT(udiPartLen));
	MD5_Transform(ADR(adwState),ADR(abyBuffer));
	udiInputOffset				:=		udiPartLen;
	WHILE udiInputOffset + 63 < udiLength DO
		MD5_Transform(ADR(adwState), pInput+udiInputOffset);
		udiInputOffset			:=		udiInputOffset + 64 ;
	END_WHILE ;
	udiIndex					:=		0;
ELSE
	udiInputOffset				:=		0 ;
END_IF

//buffer remaining input
MD5_Move(pInput+udiInputOffset,ADR(abyBuffer[udiIndex]), TO_UINT(udiLength - udiInputOffset));

pInput							:=		ADR(abBits) ;
udiLength						:=		8 ;
//MD5 block update operation. Continues an MD5 message-digest operation, processing another message block, and updating the context.

//compute number of bytes MOD 64
udiIndex						:=		SHR(adwCount[0], 3) AND 16#3F;
//update number of bits
adwCount[0]						:=		adwCount[0] + SHL(udiLength,3) ;
IF adwCount[0] < SHL(udiLength, 3) THEN
	adwCount[1]					:=		adwCount[1] + 1 ;
END_IF
adwCount[1]						:=		adwCount[1] + SHR(udiLength, 29);

udiPartLen						:=		UDINT#64 - udiIndex ;

//transform as many times as possible
IF udiLength >= udiPartLen THEN
	MD5_Move(pInput, ADR(abyBuffer[udiIndex]), TO_UINT(udiPartLen));
	MD5_Transform(ADR(adwState),ADR(abyBuffer));
	udiInputOffset				:=		udiPartLen;
	WHILE udiInputOffset + 63 < udiLength DO
		MD5_Transform(ADR(adwState), pInput+udiInputOffset);
		udiInputOffset			:=		udiInputOffset + 64 ;
	END_WHILE ;
	udiIndex					:=		0;
ELSE
	udiInputOffset				:=		0;
END_IF

//buffer remaining input
MD5_Move(pInput+udiInputOffset,ADR(abyBuffer[udiIndex]), TO_UINT(udiLength - udiInputOffset));

MD5_Move(ADR(adwState), ADR(abDigest) , 16) ;

//Convert the result of the MD5 run from binary to ascii: 16#59 ==> '59' --------
pabHelp							:=		ADR(sMD5);
FOR i := 0 TO 15 DO
	//convert first nibbel
	bHelp						:=		SHR(abDigest[i] AND 16#F0,4);
	IF bHelp <= 9 THEN
		pabHelp^[2*i]			:=		16#30 + bHelp; 		//'0'..'9'
	ELSE
		pabHelp^[2*i]			:=		16#57 + bHelp;  	//'a'..'f'    87+10 = 97 = asc('a')
	END_IF
	//convert second nibbel 
	bHelp						:=		abDigest[i] AND 16#0F;
	IF bHelp <= 9 THEN
		pabHelp^[(2*i)+1]		:=		16#30 + bHelp;  	//'0'..'9'
	ELSE
		pabHelp^[(2*i)+1]		:=		16#57 + bHelp;  	//'a'..'f'    87+10 = 97 = asc('a')
	END_IF
END_FOR
pabHelp^[32]					:=		16#00;				//append stringend
