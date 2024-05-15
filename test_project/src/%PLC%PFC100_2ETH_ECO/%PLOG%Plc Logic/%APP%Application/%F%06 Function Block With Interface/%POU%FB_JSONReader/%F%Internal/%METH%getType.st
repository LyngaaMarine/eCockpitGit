{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method checks what type the json value is, it must be given the first byte after the colon
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-07-20 | Creation
METHOD PROTECTED getType :EStructType
VAR_INPUT
	valueFirstByte		:POINTER TO EASCII;		//The position to search the json type from
END_VAR
VAR_OUTPUT
	valuePos			:POINTER TO EASCII;		//The actual start of the value after any whitespace
END_VAR
!__IMPLEMENTATION__!
//Initial result is set as invalid, when json type cannot be determined
getType								:=		EStructType.invalid;
WHILE valueFirstByte <= bufferADRMax DO
	CASE valueFirstByte^ OF
		EASCII.Smallf,EASCII.Smallt:
			valuePos				:=		valueFirstByte;
			getType					:=		EStructType.tBool;
			EXIT;
		EASCII.DoubleQoute:
			valuePos				:=		valueFirstByte;
			getType					:=		EStructType.tString;
			EXIT;
		EASCII.SqBracketO:
			valuePos				:=		valueFirstByte;
			getType					:=		EStructType.tArray;
			EXIT;
		EASCII.OpenBraces:
			valuePos				:=		valueFirstByte;
			getType					:=		EStructType.object;
			EXIT;
		EASCII.Smalln:
			valuePos				:=		valueFirstByte;
			getType					:=		EStructType.null;
			EXIT;
		EASCII.Zero,EASCII.One,EASCII.Two,EASCII.Three,EASCII.Four,EASCII.Five,EASCII.Six,EASCII.Seven,EASCII.Eight,EASCII.Nine,EASCII.Minus:
			valuePos				:=		valueFirstByte;
			getType					:=		EStructType.number;
			EXIT;
		EASCII.SqBracketC,EASCII.CloseBraces:
			getType					:=		EStructType.none;
			EXIT;
	END_CASE
	valueFirstByte					:=		valueFirstByte + 1;
END_WHILE