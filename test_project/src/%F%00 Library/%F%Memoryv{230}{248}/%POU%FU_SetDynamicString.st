{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function copies a string into dynamic memory, and cleans up any old memory
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 27-07-19 | Creation
FUNCTION FU_SetDynamicString : SLMResult
VAR_INPUT
	pStr				:REFERENCE TO POINTER TO EASCII;		//Pointer to work with
	str					:POINTER TO EASCII;		//String to copy
	maxSize				:WORD;		//Max size to limit to 0 means unlimited
END_VAR
VAR
	i					:WORD;
	blockSize			:DWORD;
	pStrPoint			:POINTER TO EASCII;
	lenBuffer			:WORD;
	nameBuffer			:POINTER TO EASCII;
	nameBufferWrite		:POINTER TO EASCII;
	nameDeleteBuffer	:POINTER TO EASCII;
	utf8Start			:POINTER TO EASCII;
END_VAR
!__IMPLEMENTATION__!
IF str = 0 THEN
	RETURN;
END_IF
//Check that string is not empty
IF str^ = EASCII.Null THEN
	IF pStr <> 0 THEN
		FU_SafeDelete(pMem:=pStr);
	END_IF
ELSE
	//The length of the input string is determined
	lenBuffer					:=		FU_wLenAI(str:=str);
	//UTF8 check is performed
	CASE FU_CheckUTF8(strStart:=str,char:=str + lenBuffer - 1,start=>utf8Start) OF
		1,2,4:
			lenBuffer			:=		lenBuffer - TO_WORD((str + lenBuffer) - utf8Start);	
	END_CASE
	IF maxSize < lenBuffer AND maxSize <> 0 THEN
		lenBuffer				:=		maxSize;
	END_IF
	blockSize					:=		FU_getBlockSizeFromPointer(pStr);
	//If the new name is not the same lenght, a new string is generated
	IF lenBuffer + 1 > blockSize OR lenBuffer < blockSize - 4 THEN
		//Byte array is generated
		blockSize				:=		lenBuffer + 1;
		nameBuffer				:=		__NEW(BYTE,blockSize);
		//Memory check
		IF nameBuffer = 0 THEN
			FU_SetDynamicString.success		:=		FALSE;
			FU_SetDynamicString.code		:=		ERCodes.FU_SetDynamicString;
			FU_SetDynamicString.reason		:=		GTErrors.EoutOfDynamicMemory;
			RETURN;
		END_IF
		//New name variable is updated with new name
		nameBufferWrite			:=		nameBuffer;
		FOR i := 0 TO lenBuffer - 1 DO
			nameBufferWrite^	:=		str^;
			nameBufferWrite		:=		nameBufferWrite + 1;
			str					:=		str + 1;
		END_FOR
		nameBufferWrite^		:=		0;
		//Old name variable is buffered for deletion
		nameDeleteBuffer		:=		pStr;
		//Name reference is set to new name
		pStr					:=		nameBuffer;
		//Old name is deleted
		IF nameDeleteBuffer <> 0 THEN
			FU_SafeDelete(pMem:=nameDeleteBuffer);
		END_IF
	//If the new name is the same length, the name is copied
	ELSE
		pStrPoint				:=		pStr;
		//New name variable is updated with new name
		FOR i := 0 TO lenBuffer - 1 DO
			pStrPoint^			:=		str^;
			pStrPoint			:=		pStrPoint + 1;
			str					:=		str + 1;
		END_FOR
		pStrPoint^				:=		0;
	END_IF
END_IF