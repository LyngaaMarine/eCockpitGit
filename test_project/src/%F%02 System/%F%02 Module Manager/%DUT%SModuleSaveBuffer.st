{"external": false, "exclude_from_build": false}
TYPE SModuleSaveBuffer :
STRUCT
	moduleUID	:AModuleUID;			//Which module event is about
	dontLog		:BOOL;					//Overwrite to prevent logging event
END_STRUCT
END_TYPE
