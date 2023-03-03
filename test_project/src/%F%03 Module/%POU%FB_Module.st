//The module class all modules should inherit from the FB_Module class
//Designator must be individual for each module, and must be set in both designator and instanceOf methods
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 02-07-19 | Creation
FUNCTION_BLOCK ABSTRACT FB_Module
VAR_INPUT
	_name				:POINTER TO AModuleName;//The name of the io
	_unit				:POINTER TO AModuleUnit;//The unit of the io
	_parent				:POINTER TO FB_Module;	//Pointer to modules parent 0 means no parent
	_UID				:AModuleUID;			//Unique id of module, used to find the module after reboots
	_SID				:AModuleSID;			//Id for the order of the module under its parent
END_VAR
VAR_OUTPUT
	_children			:POINTER TO ARRAY[0..199] OF POINTER TO FB_Module;	//List of all modules children
	_amountChildren		:WORD;					//Amount of children in the module	
END_VAR
(*%!%__DELIMITER__%!%*)
