//This function block allows for the multiple TCP listeners (eg. multiple network interfaces or ports) to share the same pool of tcp controllers
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
(*	It can be used two ways
	This way has the code directly in the same block as the connection
	FB_TCPMultiPlexer.acceptCycle();
	FOR i := 0 to ControllerSize DO
		WHILE FB_TCPController[i].readyToRecieve DO
			Code to handle request
			FB_TCPController[i].readAmount(amount:=lenght);	
		END_WHILE
	END_FOR
	FB_TCPMultiPlexer.sendCycle();
	
	This way used the event interface to decode messages
	FB_TCPMultiPlexer.acceptCycle();
	FB_TCPMultiPlexer.messageCycle();
	FB_TCPMultiPlexer.sendCycle();
*)

FUNCTION_BLOCK FB_TCPMultiPlexer IMPLEMENTS ITF_TCPControllerManagement
VAR_INPUT
	S_management		:ITF_TCPControllerManagement;
END_VAR
VAR_OUTPUT
	S_amountConnected	:WORD;
END_VAR
VAR
	S_messageEvent		:ITF_TCPControllerMessage;
	S_controllers		:POINTER TO ARRAY[0..19] OF FB_TCPController;
	S_controllersSize	:WORD;
	S_listeners			:POINTER TO ARRAY[0..19] OF TCP.Listener;
	S_listenersSize		:WORD;
	S_nextClosed		:WORD;
END_VAR

(*%!%__DELIMITER__%!%*)
