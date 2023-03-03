{"external": false, "exclude_from_build": false}
TYPE SManagementBufferBase :
STRUCT
	mid					:AMessageID;			//Number used for identifying command back to client
	event				:EManagementEvent;		//Which management event to perform
	client				:AModuleUID;			//Which client ordered event
	module				:AModuleUID;			//Which module event is about
	des					:AModuleDes;			//Designator for event
END_STRUCT
END_TYPE
