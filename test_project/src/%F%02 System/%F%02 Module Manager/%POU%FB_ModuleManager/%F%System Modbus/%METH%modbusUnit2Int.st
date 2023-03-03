{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD modbusUnit2Int
VAR_IN_OUT
	fc					:EMBFC;
	exception			:BYTE;
	decoder				:POINTER TO UMBNetMessages;
	encoder				:UMBNetMessages;	
END_VAR
VAR
	i					:WORD;
	amount				:WORD;
	address				:WORD;
	module				:AModule;
	dataPoint			:POINTER TO WORD;
END_VAR
!__IMPLEMENTATION__!
CASE decoder^.payload.head.functionCode OF
	EMBFC.FC3ReadMultipleHoldReg,EMBFC.FC4ReadInputRegisters:
		address								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.request.address);
		amount								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.request.amount);
		IF address + amount > 65535 THEN
			exception						:=		2;
		ELSE
			encoder.payload.data[0]			:=		TO_BYTE(MIN(amount,123) * 2);
			encoder.payload.head.length		:=		SysSocket_Implementation.SysSockHtons(usHost:=encoder.payload.data[0] + 3);
			FOR i := 1 TO MIN(amount,123) DO
				module						:=		GMod.modMan.getModuleByUID(modUID:=address + i);
				IF module <> 0 THEN
					dataPoint				:=		ADR(encoder.payload.data[i * 2]);
					dataPoint^				:=		TO_WORD(module^.SYS_valueSigned32);
				END_IF
			END_FOR
		END_IF
	EMBFC.FC6WriteSingleHoldReg:
		address								:=		SysSocket_Implementation.SysSockNtohs(usNet:=decoder^.single.address);
		encoder.single.address				:=		decoder^.single.address;
		encoder.single.value				:=		decoder^.single.value;
		module								:=		GMod.modMan.getModuleByUID(modUID:=address + 1);
		encoder.payload.head.length			:=		SysSocket_Implementation.SysSockHtons(usHost:=6);
		IF module <> 0 AND_THEN module^.SYS_valueAccess = EValueAccess.output THEN
			module^.SYS_valueSigned32		:=		decoder^.single.value;
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
				module						:=		GMod.modMan.getModuleByUID(modUID:=address + i);
				IF module <> 0 AND_THEN module^.SYS_valueAccess = EValueAccess.output THEN
					module^.SYS_valueSigned32:=		TO_INT(decoder^.requestPayload.data[i * 2]);
				END_IF
			END_FOR
		END_IF
ELSE
	exception								:=		1;
END_CASE