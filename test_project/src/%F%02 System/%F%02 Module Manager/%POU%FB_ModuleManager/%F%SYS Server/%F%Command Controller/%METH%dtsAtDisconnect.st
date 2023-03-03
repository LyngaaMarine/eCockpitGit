//This method is called when the data client is disconnected
//It is run in the data servers task, so don't do anything to intensive
METHOD dtsAtDisconnect
VAR_IN_OUT
	commander		:FB_DataServerCommander;			//This carries the data commander containing the data
	client			:FB_DataServerClient;				//This carries the client
END_VAR
VAR_INPUT
	reservedData	:POINTER TO BYTE;					//This is a reference to the data reserved for the command controller
END_VAR
(*%!%__DELIMITER__%!%*)
__CAST(reservedData^,SModManDataClientData).moduleSyncProgress			:=		0;
__CAST(reservedData^,SModManDataClientData).dataInitProgress			:=		0;
__CAST(reservedData^,SModManDataClientData).dataInitRuns				:=		0;
client.synced															:=		FALSE;