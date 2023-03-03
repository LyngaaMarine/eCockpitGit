//This removes a pointer from a dynamic pointer array
//It also moves all the ids after it to close the gap left
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-12-20 | Creation
//Returns true if the pointer was found in the array
FUNCTION FU_DynPointArrayOrderRemove:BOOL
VAR_IN_OUT
	arrayAmount			:WORD;	//Amount in array
	workingArray		:POINTER TO ARRAY[0..999] OF POINTER TO BYTE;	//Array
END_VAR
VAR_INPUT
	removePoint			:POINTER TO BYTE;	//The pointer to remove from the array
END_VAR
VAR_OUTPUT
	index				:WORD;			//Index of removed array pointer
END_VAR
VAR
	amountBuff			:WORD;
	offSet				:BYTE;
	i					:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
//Check for valid pointer
IF removePoint = 0 THEN
	RETURN;
END_IF
amountBuff										:=		arrayAmount;
IF arrayAmount > 0 THEN
	IF arrayAmount > 1 THEN
		FOR i := 0 TO amountBuff - offSet - 1 DO
			IF removePoint = workingArray^[i] THEN
				FU_DynPointArrayOrderRemove		:=		TRUE;
				arrayAmount						:=		arrayAmount - 1;
				offSet							:=		offSet + 1;
				index							:=		i;
			END_IF
			IF FU_DynPointArrayOrderRemove AND i < arrayAmount THEN
				workingArray^[i]				:=		workingArray^[i + offSet];
			END_IF
		END_FOR
	ELSE
		IF removePoint = workingArray^[0] THEN
			FU_DynPointArrayOrderRemove			:=		TRUE;
			arrayAmount							:=		arrayAmount - 1;
		END_IF
	END_IF
	IF FU_DynPointArrayOrderRemove THEN
		workingArray^[i]						:=		0;
	END_IF
END_IF