{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Called before data is read from buffer, if it returns true there is data to be read
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
PROPERTY readyToRecieve : BOOL
!__GETTER__!
VAR
	amount			:DINT;
END_VAR
!__IMPLEMENTATION__!
IF S_open THEN
	IF S_sendBufferSize - S_sendAmount > S_sendMaxSize AND S_messageAmount < S_maxMessages THEN
		CASE S_stream.Receive(pbyBuffer:=S_recieveBuffer + TO_DWORD(S_recieveAmount),diBufferSize:=S_recieveBufferSize - S_recieveAmount,diReceived=>amount) OF
			TCP.ERROR.NO_ERROR,TCP.ERROR.PENDING:
				S_recieveAmount				:=		S_recieveAmount + amount;
				IF S_recieveAmount >= S_headerSize THEN
					readyToRecieve			:=		TRUE;	
					S_messageAmount			:=		S_messageAmount + 1;
					IF S_message <> 0 THEN
						S_message.onMessage(controller:=THIS^,amountRecieved:=S_recieveAmount,recieveBuffer:=S_recieveBuffer,amountRead=>amount);
						IF amount > 0 THEN
							readAmount(amount:=amount);
						END_IF	
					END_IF
				END_IF
		ELSE		
			closeConnection();
		END_CASE
	END_IF	
END_IF


!__SETTER__!
