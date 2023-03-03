//Called cyclicly
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD cycle
VAR
	i			:DINT;
	sent		:DINT;
	state		:TCP.STREAM_STATE;
END_VAR
(*%!%__DELIMITER__%!%*)
IF S_open THEN
	S_messageAmount							:=		0;	
	IF S_sendAmount > 0 THEN
		CASE S_stream.Send(pbyBuffer:=S_sendBuffer,diBufferSize:=S_sendBufferSize,diSent=>sent) OF
			TCP.ERROR.NO_ERROR,TCP.ERROR.PENDING:
				IF S_sendAmount > sent THEN
					FOR i := 0 TO S_sendAmount - sent - 1 DO
						S_sendBuffer^[i]	:=		S_sendBuffer^[i + sent];
					END_FOR
					S_sendAmount			:=		S_sendAmount - sent;
				ELSE
					S_sendAmount			:=		0;
				END_IF
		ELSE
			closeConnection();
		END_CASE
	END_IF
END_IF