FUNCTION_BLOCK FB_XMLWriter
VAR_INPUT
END_VAR
VAR_OUTPUT
	EOBReached			:BOOL;				//End of buffer reached
	BufferBroken		:BOOL;				//Buffer did not finish
END_VAR
VAR
	FOR1				:BYTE;
	FileBufferADR		:POINTER TO BYTE;	//The current address where the file is being written
	FileBufferMaxADR	:POINTER TO BYTE;	//The address where the file buffer ends
	FileBufferADROG		:POINTER TO BYTE;	//The address where the file buffer starts
	Initialized			:BOOL;				//True when the initialised method has been run
	TreeLevel			:BYTE;				//How far down the XML tree, it currently is
	TreeNames			:ARRAY[0..100] OF POINTER TO BYTE; //This is an array of pointers to where the name of the start of the struct of any given tree level is in the buffer
	LastMethod			:BYTE;				//This saves which method has been run last, so the next method know what to do
	AttPosBuffer		:POINTER TO BYTE;	//This saves the position of the last attribute insersion place
END_VAR
VAR CONSTANT
	XMLDeclaration	:STRING(36) := '?xml version="1.0" encoding="UTF-8"?';
END_VAR

(*%!%__DELIMITER__%!%*)
(*	Methods IDs
1	InitialiseManager
2	AddDeclaration
3	AddString
4	AddNewLine
5	AddComment
6	AddStructStart
7	AddStructEnd
8	GetAmountByte
9	AddElement
10	AddChar
11	DenitialiseManager
12	AddAttribute
13	AddStringStrict
14	GetPositionInfo
15	MoveBufferContent
16	AddEmptyTag
*)

//Version 1 by NSN 01-05-18 Changes: Version number added to main POU
//Version 1.1 by NSN 02-05-18 Changes: AddStringStrict
