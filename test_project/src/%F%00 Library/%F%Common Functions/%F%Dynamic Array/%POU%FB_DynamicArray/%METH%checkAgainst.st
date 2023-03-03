//BLOCKING Method, method will block thread until exclusive access to array is available
//Compares the given element to the element on the index in the array
//Returns true if element is the same
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD checkAgainst : BOOL
VAR_INPUT
	element		:POINTER TO BYTE;	//Element to check
	elementSize	:WORD;		//Size of element
	index		:WORD;		//Index
END_VAR
VAR
	i			:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF index < S_lenght THEN
	checkAgainst		:=		compare(elementInt:=S_array^ + (index * S_elementSize),elementExt:=element,elementExtSize:=elementSize);
END_IF