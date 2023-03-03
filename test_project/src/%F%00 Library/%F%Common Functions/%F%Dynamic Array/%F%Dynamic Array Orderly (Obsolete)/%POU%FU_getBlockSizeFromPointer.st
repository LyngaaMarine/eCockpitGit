//Finds the block header from a codesys dynamic memory block
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-12-20 | Creation
FUNCTION FU_getBlockSizeFromPointer : DWORD
VAR_INPUT
	pData		:POINTER TO BYTE;
END_VAR
var
	pHeader		:POINTER TO CMM.LMMBlock := pData - 12;
END_VAR
(*%!%__DELIMITER__%!%*)
IF pData <> 0 THEN
	FU_getBlockSizeFromPointer			:=		pHeader^.dwSize - 16;
ELSE
	FU_getBlockSizeFromPointer			:=		0;
END_IF
