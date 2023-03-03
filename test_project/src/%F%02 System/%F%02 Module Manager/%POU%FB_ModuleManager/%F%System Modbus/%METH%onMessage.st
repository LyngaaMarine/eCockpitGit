{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
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
VAR
	lenght				:WORD;
	decoder				:POINTER TO UMBNetMessages := recieveBuffer;
	encoder				:UMBNetMessages;
	exception			:BYTE;
END_VAR
!__IMPLEMENTATION__!
lenght												:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.payload.head.length) + 6;
IF amountRecieved < lenght THEN
	onMessage										:=		TRUE;
	RETURN;
END_IF
encoder.payload.head.transID						:=		decoder^.payload.head.transID;
encoder.payload.head.functionCode					:=		decoder^.payload.head.functionCode;
encoder.payload.head.unitID							:=		decoder^.payload.head.unitID;
CASE decoder^.payload.head.unitID OF
	0:	//Unit id 0 is boolean values
		modbusUnit0Boolean(fc:=encoder.payload.head.functionCode,exception:=exception,decoder:=decoder,encoder:=encoder);
// 	1:	//Unit id 1 is word values
// 		modbusUnit1Word(fc:=encoder.payload.head.functionCode,exception:=exception,decoder:=decoder,encoder:=encoder);
// 	2:	//Unit id 2 is int values
// 		modbusUnit2Int(fc:=encoder.payload.head.functionCode,exception:=exception,decoder:=decoder,encoder:=encoder);
// 	3,4://Unit id 3,4 is dword values
// 		modbusUnit3_4Dword(fc:=encoder.payload.head.functionCode,exception:=exception,decoder:=decoder,encoder:=encoder,unitOffset:=(decoder^.payload.head.unitID - 3) * 32767);
ELSE
	exception										:=		11;
END_CASE
IF exception <> 0 THEN
	encoder.payload.head.functionCode				:=		decoder^.payload.head.functionCode + 128;
	encoder.payload.data[0]							:=		exception;
	encoder.payload.head.length						:=		SysSocket_Implementation.SysSockHtons(usHost:=3);
END_IF
controller.sendData(data:=ADR(encoder),size:=SysSocket_Implementation.SysSockNtohs(usNet:=encoder.payload.head.length) + 6);
amountRead											:=		lenght;