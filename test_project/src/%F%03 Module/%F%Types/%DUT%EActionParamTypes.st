{attribute 'qualified_only'}
{attribute 'strict'}
//This contains all the allowed types for action parameter
TYPE EActionParamTypes :(
	tBool,		//True/false
	tInt32,		//32 bit integer
	tUint32,	//32 bit unsigned integer
	tFloat32,	//32 bit floating point number
	tModule		//Module ID
) BYTE; END_TYPE