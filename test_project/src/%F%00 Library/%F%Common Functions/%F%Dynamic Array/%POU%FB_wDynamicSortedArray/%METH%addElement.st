//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Appends element to array
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD addElement : SLMResult
VAR_INPUT
	element			:WORD;	//Element to append
END_VAR
VAR_OUTPUT
	index			:WORD;
END_VAR
VAR
	i				:WORD;
	size			:WORD;		//Size to allocate to array
	offset			:WORD;
	newArrayBuffer	:POINTER TO ARRAY[0..99] OF WORD;
END_VAR

(*%!%__DELIMITER__%!%*)
IF S_lenght < S_maxSize THEN
	IF S_map THEN
		IF checkExists(element:=element) THEN
			addElement.success			:=		FALSE;
			addElement.code				:=		ERCodes.FB_DynamicArray_addElement;
			addElement.reason			:=		GTErrors.EelementInArray;
			RETURN;
		END_IF
	END_IF
	//If array is full, then more space is allocated
	IF S_lenght < S_blockSize THEN
		FOR i := S_lenght TO 1 BY -1 DO
			IF S_array^[i - 1] <= element THEN
				S_array^[i]				:=		element;
				EXIT;
			ELSE
				S_array^[i]				:=		S_array^[i - 1];
			END_IF
		END_FOR
		IF i = 0 THEN
			S_array^[0]					:=		element;
		END_IF
	ELSE
		//Size is corrected to increment size
		size								:=		((S_blockSize / S_increment) + 1) * S_increment;
		//Byte size is calculated
		newArrayBuffer						:=		__NEW(WORD,size);
		//If the memory manager fails, the registerering fails
		IF newArrayBuffer = 0 THEN
			addElement.success				:=		FALSE;
			addElement.code					:=		ERCodes.FB_DynamicArray_allocateInternal;
			addElement.reason				:=		GTErrors.EoutOfDynamicMemory;
			RETURN;
		END_IF
		//The contens of the old buffer is copied to the new buffer
		IF S_lenght > 0 THEN
			FOR i := 0 TO S_lenght - 1 DO
				IF offset = 0 AND S_array^[i] >= element THEN
					newArrayBuffer^[i]		:=		element;
					offset					:=		1;
				END_IF
				newArrayBuffer^[i + offset]	:=		S_array^[i];
			END_FOR
			IF offset = 0 AND i = S_lenght THEN
				newArrayBuffer^[i]			:=		element;
			END_IF
		ELSE
			newArrayBuffer^[0]				:=		element;
		END_IF
		//Old array memory is deleted, and new one is use
		FU_SafeDelete(pMem:=S_array);
		S_array								:=		newArrayBuffer;
		S_blockSize							:=		size;
	END_IF
	index									:=		S_lenght;
	S_lenght								:=		S_lenght + 1;
ELSE
	addElement.success						:=		FALSE;
	addElement.code							:=		ERCodes.FB_DynamicArray_addElement;
	addElement.reason						:=		GTErrors.EarrayFull;
END_IF