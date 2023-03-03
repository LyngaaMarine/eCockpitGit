{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 25-04-18 | Creation
METHOD PROTECTED CopyBufferContent
VAR_INPUT
	pMoveFrom		:POINTER TO BYTE;	//Address of the move from string
	pMoveTo			:POINTER TO BYTE;	//Address of the move to place
	dwAmount		:DWORD;				//Amount to move
END_VAR
VAR
	WatchDog		:BYTE;		//Watchdog for keeping addresse reading in check
	MethodID		:BYTE := 15;	//ID for keeping track of run methods
END_VAR
!__IMPLEMENTATION__!
IF Initialized AND EOBReached = FALSE THEN		//It only runs when a buffer has been initialized
	pMoveFrom					:=		pMoveFrom + dwAmount;
	pMoveTo						:=		pMoveTo + dwAmount;
	IF pMoveFrom < FileBufferMaxADR AND pMoveTo < FileBufferMaxADR THEN
		dwAmount				:=		dwAmount + 1;
		WHILE dwAmount > 0 DO
			IF WatchDog >= 3000 THEN
				EXIT;
			END_IF
			WatchDog			:=		WatchDog + 1;
			pMoveTo^			:=		pMoveFrom^;
			dwAmount			:=		dwAmount - 1;
			pMoveFrom			:=		pMoveFrom - 1;
			pMoveTo				:=		pMoveTo - 1;
		END_WHILE
		//Last Method is recorded
		LastMethod				:=		MethodID;
	ELSE								//When the last address is encountered, the end of buffer variable is set true
		EOBReached				:=		TRUE;
		BufferBroken			:=		TRUE;
	END_IF
END_IF
