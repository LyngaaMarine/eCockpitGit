VAR
	amount			:DINT;
END_VAR
(*%!%__DELIMITER__%!%*)
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

