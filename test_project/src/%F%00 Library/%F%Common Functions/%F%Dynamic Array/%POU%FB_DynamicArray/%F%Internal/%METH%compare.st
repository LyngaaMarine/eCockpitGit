//Internal function to compare two elements correctly
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD PRIVATE compare : BOOL
VAR_INPUT
	elementInt		:POINTER TO BYTE;	//Internal element to compare
	elementExt		:POINTER TO BYTE;	//External element to compare
	elementExtSize	:WORD;				//Size of external element
END_VAR
VAR
	i				:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_strings OR elementExtSize = S_elementSize THEN 
	//If first byte in element and first byte in array position are the same
	IF elementExt^ = elementInt^ THEN
		compare		:=		TRUE;
		IF S_elementSize > 1 THEN
			IF S_strings THEN
				//String array will account for zero termination
				FOR i := 0 TO S_elementSize - 1 DO
					IF elementExt[i] <> elementInt[i] THEN
						compare		:=		FALSE;
						EXIT;
					ELSIF elementExt[i] = 0 THEN
						IF elementInt[i] = 0 THEN
							EXIT;
						ELSE
							compare		:=		FALSE;
							EXIT;
						END_IF
					END_IF
				END_FOR
			ELSE
				//Normal type check entire element
				FOR i := 0 TO S_elementSize - 1 DO
					IF elementExt[i] <> elementInt[i] THEN
						compare		:=		FALSE;
						EXIT;
					END_IF
				END_FOR
			END_IF
		END_IF
	END_IF
END_IF