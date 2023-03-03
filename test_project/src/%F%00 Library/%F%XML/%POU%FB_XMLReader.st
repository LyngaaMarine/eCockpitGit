{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Does NOT currently support empty elements 
//The Initialize method must be run first, 
//To search for a struct, run the MoveToStruct method, the cursor is then moved to the found struct if one is found
//
//To search for an attribute, run the MoveToAtt method, if a struct was previously found, the search continues from that struct
//To extract the attribute value, run the CopyAttVal method
//
//To search for a tag, run the MoveToTag method
//To extract the tag value, run the CopyTagVal method
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 25-01-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION_BLOCK FB_XMLReader
VAR
//Initialize
	Initialized				:BOOL;				//True when the initialised method has been run
//FileBuffer
	FileBufferMaxADR		:POINTER TO BYTE;	//The address where the file buffer ends
	FileBufferADROG			:POINTER TO BYTE;	//The address where the file buffer starts
	FileBufferSize			:DWORD;				//Size of the linked buffer
//Cursor
	ADRCursor				:POINTER TO BYTE;	//The current address where the file is being written
//Buffers
	AttDataBuffer			:POINTER TO BYTE;	//Buffer of address where attribute data is
	TagDataBuffer			:POINTER TO BYTE;	//Buffer of address where tag data is
	TreeLevel				:INT;				//This keeps track of how deep in the tree the cursor is
	StructPositions			:ARRAY[0..254] OF POINTER TO BYTE; //This saves the previus found struct address, to return to and search from again 
	StructPosOffset			:BYTE;				//How many previusly found structs are saved 
	StructPosOffset2		:BYTE := 1;			//How many previusly found structs are saved
	DeclarationEnd			:POINTER TO BYTE;	//This saves the position of the end of the declaration
END_VAR
VAR CONSTANT
	XMLDecFirstCheck		:STRING(4)		:=		'?xml';
	XMLDecCheckVersion		:STRING(7)		:=		'version';
	XMLDecCheckEncoding		:STRING(8)		:=		'encoding';
	XMLDecCheckStandalone	:STRING(10)		:=		'standalone';
	XMLDoubleQoute			:STRING(1)		:=		'"';
	XMLEqual				:STRING(1)		:=		'=';
	XMLStartTag				:STRING(1)		:=		'<';
	XMLEndTag				:STRING(1)		:=		'>';
	XMLSpace				:STRING(1)		:=		' ';
END_VAR
!__IMPLEMENTATION__!
(*
How to use



*)