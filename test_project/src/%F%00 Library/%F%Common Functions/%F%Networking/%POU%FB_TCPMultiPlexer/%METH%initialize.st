//Initializes the tcp controller with needed values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD initialize : SLMResult
VAR_INPUT
	controllers			:POINTER TO ARRAY[0..19] OF FB_TCPController;	//List of controllers to handle connections
	controllersSize		:WORD;											//Size of controller list
	listeners			:POINTER TO ARRAY[0..19] OF TCP.Listener;		//List of listeners to check for incoming connections
	listenersSize		:WORD;											//Size of listener list
END_VAR
VAR
	i					:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF controllers = 0 OR controllersSize = 0 OR listeners = 0 OR listenersSize = 0 THEN
	initialize.success					:=		FALSE;
	initialize.code						:=		ERCodes.FB_TCPMultiPlexer_initialize;
	RETURN;
END_IF
S_controllers							:=		controllers;
S_controllersSize						:=		controllersSize;
FOR i := 0 TO controllersSize - 1 DO
	S_controllers^[i].S_management		:=		THIS^;
	S_controllers^[i].S_index			:=		i;
	IF S_messageEvent <> 0 THEN
		S_controllers^[i].S_message		:=		S_messageEvent;
	END_IF
END_FOR

S_listeners								:=		listeners;
S_listenersSize							:=		listenersSize;