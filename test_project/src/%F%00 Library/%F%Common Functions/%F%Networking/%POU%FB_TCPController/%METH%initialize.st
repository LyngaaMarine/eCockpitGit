//Initializes the tcp controller with needed values
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD initialize : SLMResult
VAR_INPUT
	recieveBuffer		:POINTER TO ARRAY[0..99] OF BYTE;	//Reference to recieve buffer
	recieveBufferSize	:DINT;								//Size of recieve buffer
	sendBuffer			:POINTER TO ARRAY[0..99] OF BYTE;	//Reference to send buffer
	sendBufferSize		:DINT;								//Size of send buffer
	sendMaxSize			:DINT;								//Estimated max size of sending message, this makes sure that recieved messages are only processed when there is enough space to send the response in the send buffer
	maxMessages			:DINT;								//Limit for how many messages can be decoded per cycle
	headerSize			:DINT;								//Size of header for tcp message, reading wait until there is at least this amount in the buffer before decoding is performed
END_VAR

(*%!%__DELIMITER__%!%*)
IF recieveBuffer = 0 OR recieveBufferSize = 0 OR sendBuffer = 0 OR sendBufferSize = 0 THEN
	initialize.success	:=		FALSE;
	initialize.code		:=		ERCodes.FB_TCPController_initialize;
	RETURN;
END_IF
S_recieveBuffer			:=		recieveBuffer;
S_recieveBufferSize		:=		recieveBufferSize;
S_sendBuffer			:=		sendBuffer;
S_sendBufferSize		:=		sendBufferSize;
S_sendMaxSize			:=		sendMaxSize;
IF maxMessages = 0 THEN
	S_maxMessages		:=		1000;
ELSE
	S_maxMessages		:=		maxMessages;
END_IF
S_headerSize			:=		headerSize;