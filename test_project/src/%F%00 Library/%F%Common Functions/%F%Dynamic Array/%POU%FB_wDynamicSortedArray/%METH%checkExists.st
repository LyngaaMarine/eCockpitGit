//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Checks if element exist in array, and returns index of element in array
//Returns true if element is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD checkExists : BOOL
VAR_INPUT
	element		:WORD;		//Element to check
END_VAR
VAR_OUTPUT
	index		:WORD;		//Index of found element
END_VAR
VAR
	lower		:DINT;
	upper		:DINT := S_lenght - 1;
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_lenght > 0 THEN
	WHILE TRUE DO
		index					:=		 TO_WORD(SHR((lower + upper),1));
		IF S_array^[index] > element THEN
			upper				:=		index - 1;
		ELSIF S_array^[index] < element THEN
			lower				:=		index + 1;
		ELSE
			checkExists			:=		TRUE;
			RETURN;
		END_IF
		IF lower > upper THEN
			index				:=		0;
			RETURN;
		END_IF
	END_WHILE
END_IF