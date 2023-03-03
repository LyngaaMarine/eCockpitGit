METHOD modbusUnit3_4Dword
VAR_IN_OUT
	fc					:EMBFC;
	exception			:BYTE;
	decoder				:POINTER TO UMBNetMessages;
	encoder				:UMBNetMessages;	
END_VAR
VAR_INPUT
	unitOffset			:WORD;
END_VAR
VAR
	i					:WORD;
	amount				:WORD;
	address				:WORD;
	module				:AModule;
	dataPoint			:POINTER TO WORD;
	buffer				:UMBIORaw;
END_VAR
(*%!%__DELIMITER__%!%*)
CASE decoder^.payload.head.functionCode OF
	EMBFC.FC3ReadMultipleHoldReg,EMBFC.FC4ReadInputRegisters:
		address								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.request.address);
		amount								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.request.amount);
		IF address + amount > 65535 THEN
			exception						:=		2;
		ELSE
			encoder.payload.data[0]			:=		TO_BYTE(MIN(amount,123) * 2);
			encoder.payload.head.length		:=		SysSocket_Implementation.SysSockHtons(usHost:=encoder.payload.data[0] + 3);
			FOR i := 1 TO MIN(amount,123) BY 2 DO
				module						:=		GMod.modMan.getModuleByUID(modUID:=address + i + unitOffset);
				IF module <> 0 THEN
					buffer.unsigned32		:=		TO_WORD(module^.SYS_valueUnsigned32);
					dataPoint				:=		ADR(encoder.payload.data[i * 2]);
					dataPoint^				:=		buffer.words[1];
					dataPoint[1]			:=		buffer.words[0];
				END_IF
			END_FOR
		END_IF
	EMBFC.FC16WriteMultiHoldReg:
		address								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.request.address);
		amount								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.request.amount);
		IF address + amount > 65535 THEN
			exception						:=		2;
		ELSE
			encoder.request.address			:=		decoder^.request.address;
			encoder.request.amount			:=		decoder^.request.amount;
			encoder.payload.head.length		:=		SysSocket_Implementation.SysSockHtons(usHost:=6);
			FOR i := 1 TO amount DO
				module						:=		GMod.modMan.getModuleByUID(modUID:=address + i + unitOffset);
				IF module <> 0 AND_THEN module^.SYS_valueAccess = EValueAccess.output THEN
					module^.SYS_valueUnsigned32:=		decoder^.requestPayload.data[i * 2];
				END_IF
			END_FOR
		END_IF
ELSE
	exception								:=		1;
END_CASE