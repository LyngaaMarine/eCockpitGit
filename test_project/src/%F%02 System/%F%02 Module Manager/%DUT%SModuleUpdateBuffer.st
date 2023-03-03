TYPE SModuleUpdateBuffer :
STRUCT
	moduleUID			:AModuleUID;			//Which module event is about
	clientUID			:AModuleUID;			//Which client ordered event
	mid					:AMessageID;			//Number used for identifying command back to client
END_STRUCT
END_TYPE
