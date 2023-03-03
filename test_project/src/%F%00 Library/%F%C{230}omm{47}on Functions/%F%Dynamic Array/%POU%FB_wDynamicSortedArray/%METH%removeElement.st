{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Finds and removes the given element from the array, if multiple are found the amount of elements removed are limited by the amount given
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD removeElement
VAR_INPUT
	element			:WORD;		//Element to remove
	amount			:WORD;		//Max amount of same elements to remove from array, 0 means all
END_VAR
VAR
	i				:WORD;
	offset			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF S_lenght > 0 THEN
	FOR i := 0 TO S_lenght - 1 DO
		IF S_array^[i] = element AND (offset < amount OR amount = 0) THEN
			offset					:=		offset + 1;
		ELSIF offset > 0 THEN
			S_array^[i - offset]	:=		S_array^[i];
		END_IF
	END_FOR
	S_lenght						:=		S_lenght - offset;
	IF S_lenght = 0 THEN
		S_blockSize					:=		0;
		FU_SafeDelete(pMem:=S_array);
	END_IF
END_IF