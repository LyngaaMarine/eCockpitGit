{"external": false, "exclude_from_build": false}
//Struct containing needed information to perform af 3 point calibration from a module value
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
TYPE SModuleValueConversion3Point :
STRUCT
	moduleUID		:AModuleUID;	//UID of module with value
	minValue		:UValue;		//Minimum value of conversion
	midValue		:UValue;		//Middle value of conversion
	maxValue		:UValue;		//Maximum value of conversion
END_STRUCT
END_TYPE
