{"external": false, "exclude_from_build": false}
TYPE SVar :
//This struct contains value in raw format
//It contains a pointer to the value, the systype of the value, and the offset, in case the value is a bool which is part of another type
STRUCT
	sAny		:SAny;				//Data about variable
	bOffset		:BYTE;				//Bit offset of value if the value contains multiple bools in one byte address, 1 is the first bit of the byte
END_STRUCT
END_TYPE