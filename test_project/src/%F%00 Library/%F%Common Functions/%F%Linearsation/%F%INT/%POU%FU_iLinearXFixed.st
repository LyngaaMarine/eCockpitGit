//This function, converts an x value to a fixed y value
//When the input is between two x values, the corresponding y value is outputted
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 03-01-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_iLinearXFixed : INT
VAR_INPUT
	iXIn		:INT;					//Input value
	pXArray		:POINTER TO INT;		//Address of x array
	uiXSize		:UINT;					//Size of x array
	pYArray		:POINTER TO INT; 		//Address of y array
	uiYSize		:UINT; 					//Size of y array
END_VAR
VAR
	XAddBuff	:POINTER TO INT;
	SmallestSize:UINT;
END_VAR
(*%!%__DELIMITER__%!%*)
XAddBuff				:=		pXArray + 2;
IF uiXSize > uiYSize THEN
	SmallestSize		:=		uiYSize;
ELSE	
	SmallestSize		:=		uiXSize;
END_IF
IF pXArray^ < XAddBuff^ THEN
	WHILE SmallestSize > 0 DO
		SmallestSize			:=		SmallestSize - 1;
		IF iXIn < XAddBuff^ OR SmallestSize = 0 THEN
			FU_iLinearXFixed	:=		pYArray^;
			RETURN;
		ELSE
			XAddBuff			:=		XAddBuff + 2;
			pYArray				:=		pYArray + 2;
		END_IF
	END_WHILE
ELSE
	WHILE SmallestSize > 0 DO
		SmallestSize			:=		SmallestSize - 1;
		IF iXIn > XAddBuff^ OR SmallestSize = 0 THEN
			FU_iLinearXFixed	:=		pYArray^;
			RETURN;
		ELSE
			XAddBuff			:=		XAddBuff + 2;
			pYArray				:=		pYArray + 2;
		END_IF
	END_WHILE
END_IF
