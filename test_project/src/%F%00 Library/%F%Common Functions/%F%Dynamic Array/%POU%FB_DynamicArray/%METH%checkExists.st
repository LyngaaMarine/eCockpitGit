//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Checks if element exist in array, and returns index of element in array
//Returns true if element is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD checkExists : BOOL
VAR_INPUT
	element		:POINTER TO BYTE;	//Element to check
	elementSize	:WORD;		//Size of element
END_VAR
VAR_OUTPUT
	index		:WORD;		//Index of found element
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_lenght > 0 THEN
	//Array is searched until element is found
	FOR index := 0 TO S_lenght - 1 DO
		IF compare(elementInt:=S_array^ + (index * S_elementSize),elementExt:=element,elementExtSize:=elementSize) THEN
			checkExists		:=		TRUE;
			RETURN;
		END_IF
	END_FOR
END_IF
index								:=		0;