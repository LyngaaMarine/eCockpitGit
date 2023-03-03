//Called when controller recieves another message
//Returns true if there is not enough data in buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD onMessage : BOOL
VAR_IN_OUT
	controller			:FB_TCPController;	//Controller which is closed
END_VAR
VAR_INPUT
	amountRecieved		:DINT;				//Amount of data ready in the recieve buffer
	recieveBuffer		:POINTER TO BYTE;	//Pointer to recieve buffer
END_VAR
VAR_OUTPUT
	amountRead			:DINT;				//The amount of data read from the buffer must be returned here
END_VAR
(*%!%__DELIMITER__%!%*)
