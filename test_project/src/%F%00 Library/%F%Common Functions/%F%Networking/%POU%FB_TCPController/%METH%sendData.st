//Called to load data into send buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD sendData : BOOL
VAR_INPUT
	data		:POINTER TO BYTE;
	size		:DINT;
END_VAR
VAR
	i			:DINT;
	sent		:DINT;
	remaining	:DINT;
END_VAR

(*%!%__DELIMITER__%!%*)
//If there is space in the send buffer
IF S_sendBufferSize - S_sendAmount >= size THEN
	IF S_sendAmount > 0 THEN
		FOR i := 0 TO size - 1 DO
			S_sendBuffer^[i + S_sendAmount]			:=		data[i];
		END_FOR
		S_sendAmount								:=		size;
	ELSE
		CASE S_stream.Send(pbyBuffer:=data,diBufferSize:=size,diSent=>sent) OF
			TCP.ERROR.NO_ERROR,TCP.ERROR.PENDING:
				IF size > sent THEN
					remaining							:=		size - sent;
					FOR i := 0 TO remaining - 1 DO
						S_sendBuffer^[i + S_sendAmount]	:=		data[i];
					END_FOR
					S_sendAmount						:=		S_sendAmount + remaining;
				END_IF
		ELSE
			closeConnection();
		END_CASE
	END_IF
END_IF