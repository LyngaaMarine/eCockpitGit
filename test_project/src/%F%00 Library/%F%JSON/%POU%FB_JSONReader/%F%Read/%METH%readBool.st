METHOD readBool :BOOL
VAR
	valueBuff	:STRING(30);
END_VAR
(*%!%__DELIMITER__%!%*)
IF ready THEN
	CASE lastValueType OF
		EStructType.tBool:
			readBool				:=		lastValueStart^ = EASCII.Smallt;
		EStructType.number:
			readString(str:=ADR(valueBuff),lenMax:=30);
			readBool				:=		TO_BOOL(TO_REAL(valueBuff));
		EStructType.null:;
		EStructType.object,EStructType.tArray:
			readBool				:=		amountInSelection > 0;
		EStructType.tString:
			readString(str:=ADR(valueBuff),lenMax:=5);
			readBool				:=		TO_BOOL(valueBuff);
			IF NOT(readBool) THEN
				readBool			:=		valueBuff[0] <> 0;
			END_IF
	END_CASE
END_IF