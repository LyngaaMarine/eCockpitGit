{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This function block helps write json files, by methodising it
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
FUNCTION_BLOCK FB_JSONWriter IMPLEMENTS ITF_StructWriterBase
VAR_OUTPUT
	bufferAddress		:POINTER TO EASCII;	//The address where the file buffer starts
	bufferInvalid		:BOOL;
END_VAR
VAR
	ready				:BOOL;				//True when the initialised method has been run
	bufferPosition		:POINTER TO EASCII;	//The current address where the file is being written
	bufferMaxADR		:POINTER TO EASCII;	//The address where the file buffer ends
	treeLevel			:WORD;			//How far down the json tree, it currently is
	treeTypes			:ARRAY[1..levelsMax] OF EStructType;
	treeSingleLine		:ARRAY[1..levelsMax] OF BOOL;
	useSingleLine		:BOOL;				//Wether the JSON should be written to a single file
	bottomTypeInt		:EStructType;
	inArray				:BOOL;				//True when writing in array
	inObject			:BOOL;				//True when writing in object
	afterKey			:BOOL;				//True when just after a key
	singleVal			:BOOL;
	emptyBlock			:BOOL;
	lastComma			:POINTER TO EASCII;	//The address where the file buffer ends
END_VAR
VAR CONSTANT
	levelsMax			:BYTE:=20;
	stringMaxLen		:BYTE := 255;
END_VAR
!__IMPLEMENTATION__!
