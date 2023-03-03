FUNCTION FU_InitGMemory : BOOL
VAR
	memBuff		:POINTER TO DWORD;
	memBlock	:POINTER TO CMM.LMMBlock;
END_VAR

(*%!%__DELIMITER__%!%*)
memBuff							:=		__NEW(DWORD);
IF memBuff <> 0 THEN
	memBlock					:=		memBuff - 12;
	WHILE memBlock^.pPreviousBlock <> 0 DO
		memBlock				:=		memBlock^.pPreviousBlock;
	END_WHILE
	GMemory.dynamicStart		:=		TO_DWORD(memBlock) + 12;
	__DELETE(memBuff);
END_IF
