{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//The Initialize method must be run first
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-07-20 | Creation
FUNCTION_BLOCK FB_JSONReader IMPLEMENTS ITF_StructReaderBase
VAR
//Initialize
	ready					:BOOL;				//True when the initialised method has been run
	bufferADRMax			:POINTER TO EASCII;	//The address where the file buffer ends
	bufferADROrg			:POINTER TO EASCII;	//The address where the file buffer starts
	buttomType				:EStructType;		//This saves the buttom type of the json data
	lastValueStart			:POINTER TO EASCII;
	lastValueType			:EStructType;
	lastKeyStart			:POINTER TO EASCII;
	lastKeySize				:WORD;
	treeLevel				:BYTE;				//How far down the json tree, it currently is
	treeSelectedTypes		:ARRAY[1..levelsMax] OF EStructType;
	treeSelected			:ARRAY[1..levelsMax] OF POINTER TO EASCII;
	treeSelectedArrayProg	:ARRAY[1..levelsMax] OF WORD;
END_VAR
VAR CONSTANT
	levelsMax				:BYTE:=20;
	stringMaxLen			:BYTE:=255;
END_VAR
!__IMPLEMENTATION__!
