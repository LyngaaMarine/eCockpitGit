{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Called to accept tcp connection
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD acceptConnection : BOOL
VAR_IN_OUT
	listener			:TCP.Listener;
END_VAR
VAR
	tcpError			:TCP.ERROR;
END_VAR
!__IMPLEMENTATION__!
IF NOT(S_open) THEN
	IF listener.Accept(pStream:=ADR(S_stream)) = TCP.ERROR.NO_ERROR THEN
		S_open					:=		TRUE;
		acceptConnection		:=		TRUE;	
		IF S_management <> 0 THEN
			S_management.onOpen(index:=S_index,controller:=THIS^);			
		END_IF
	END_IF	
END_IF