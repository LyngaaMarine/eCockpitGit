{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD PROTECTED MD5_Move : BOOL
//Function copy "uiNumberOfBytes" of memory from "Source" to "Destination"
//The function works even if source and destination overlaps
//Function normally return TRUE
//If "pSource" or "pDestination" are "0" nothing is moved and the function return FALSE
VAR_INPUT
	pSource				:POINTER TO BYTE;		//Address of source memory
	pDestination		:POINTER TO BYTE;		//Address of destination memory
	uiNumberOfBytes		:UINT;		//Number of bytes to move
END_VAR
VAR
	pbySource,pbyDestination	:POINTER TO BYTE;
	uiLoopCounter		:UINT;
END_VAR

!__IMPLEMENTATION__!
IF pSource=0 OR pDestination=0 THEN
	MD5_Move			:=		FALSE;
ELSIF pSource > pDestination THEN
	pbySource				:=		pSource;
	pbyDestination			:=		pDestination;
	FOR uiLoopCounter := 1 TO uiNumberOfBytes DO
		pbyDestination^		:=		pbySource^;
		pbySource			:=		pbySource + 1;
		pbyDestination		:=		pbyDestination + 1;
	END_FOR
	MD5_Move			:=		TRUE;
ELSIF pSource < pDestination THEN
	pbySource				:=		pSource + uiNumberOfBytes - 1;
	pbyDestination			:=		pDestination + uiNumberOfBytes - 1;
	FOR uiLoopCounter := 1 TO uiNumberOfBytes DO
		pbyDestination^		:=		pbySource^;
		pbySource			:=		pbySource - 1;
		pbyDestination		:=		pbyDestination - 1;
	END_FOR
	MD5_Move			:=		TRUE;
END_IF