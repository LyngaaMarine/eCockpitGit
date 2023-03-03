//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Finds and removes the given element from the array, if multiple are found the amount of elements removed are limited by the amount given
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 07-03-22 | Creation
METHOD removeElement
VAR_INPUT
	element			:POINTER TO BYTE;	//Element to remove
	elementSize		:WORD;		//Size of element
	amount			:WORD;		//Max amount of same elements to remove from array, 0 means all
END_VAR
VAR
	i				:WORD;
	offset			:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_lenght > 0 THEN
	FOR i := 0 TO S_lenght - 1 DO
		IF compare(elementInt:=S_array^ + (i * S_elementSize),elementExt:=element,elementExtSize:=elementSize) AND (offset < amount OR amount = 0) THEN
			offset				:=		offset + 1;
		ELSIF offset > 0 THEN
			SysMem.SysMemCpy(pDest:=S_array^ + ((i - offset) * S_elementSize),pSrc:=S_array^ + (i * S_elementSize),udiCount:=S_elementSize);
		END_IF
	END_FOR
	S_lenght						:=		S_lenght - offset;
	IF S_lenght = 0 THEN
		S_blockSize					:=		0;
		FU_SafeDelete(pMem:=S_array^);
	END_IF
END_IF