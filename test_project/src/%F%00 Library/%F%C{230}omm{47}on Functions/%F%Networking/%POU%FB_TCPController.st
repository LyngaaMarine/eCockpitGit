{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Controller to simplify TCP connection
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
(*	It can be used two ways
	This way has the code directly in the same block as the connection
	IF FB_TCPController.acceptConnection(listener:=TCP.listener) THEN
		//Connection established
	END_IF

	WHILE FB_TCPController.readyToRecieve DO
		Code to handle request
		FB_TCPController.readAmount(amount:=lenght);	
	END_WHILE
	FB_TCPController.cycle();
	
	This way used the message event interface to handle decoding messages
	FB_TCPController.S_message	:=		HandlerForMessages;
	IF FB_TCPController.acceptConnection(listener:=TCP.listener) THEN
		//Connection established
	END_IF

	WHILE FB_TCPController.readyToRecieve DO ; END_WHILE
	FB_TCPController.cycle();
*)

FUNCTION_BLOCK FB_TCPController
VAR_INPUT
	S_index				:WORD;								//Index used to identify controller
	S_management		:ITF_TCPControllerManagement;		//Interface for management events
	S_message			:ITF_TCPControllerMessage;			//Interface for message events
END_VAR
VAR_OUTPUT
	S_open				:BOOL;								//Is true when connection is open
	S_recieveAmount		:DINT;								//How much is left in recieve buffer
END_VAR
VAR
	S_recieveBuffer		:POINTER TO ARRAY[0..99] OF BYTE;	//Reference to recieve buffer
	S_recieveBufferSize	:DINT;								//Size of recieve buffer
	S_sendBuffer		:POINTER TO ARRAY[0..99] OF BYTE;	//Reference to send buffer
	S_sendBufferSize	:DINT;								//Size of send buffer
	S_sendMaxSize		:DINT;								//Estimated max size of sending message, this makes sure that recieved messages are only processed when there is enough space to send the response in the send buffer
	S_maxMessages		:DINT;								//Limit for how many messages can be decoded per cycle
	S_headerSize		:DINT;								//Size of header for tcp message, reading wait until there is at least this amount in the buffer before decoding is performed
	S_stream			:TCP.Stream;
	S_recieveOffset		:DINT;
	S_sendAmount		:DINT;
	S_messageAmount		:DINT;
END_VAR
!__IMPLEMENTATION__!
