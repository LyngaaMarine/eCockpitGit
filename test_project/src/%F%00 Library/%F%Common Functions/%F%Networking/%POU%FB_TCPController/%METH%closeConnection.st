//Called to close and clean up connection
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD closeConnection
(*%!%__DELIMITER__%!%*)
S_stream.Close();
S_stream.Reset();
S_open			:=		FALSE;
IF S_management <> 0 THEN
	S_management.onClose(index:=S_index,controller:=THIS^);			
END_IF