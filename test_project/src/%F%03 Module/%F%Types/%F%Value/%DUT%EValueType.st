{"external": false, "exclude_from_build": false}
{attribute 'qualified_only'}
{attribute 'strict'}
//This contains all the different types of values
TYPE EValueType :(
	none				//No value
	,digital			//For digital values, will return On or Off
	,signed32			//For signed 32bit values
	,unsigned32			//For unsigned 32bit values
	,signed64			//For signed 64bit values
	,unsigned64			//For unsigned 64bit values
	,enum				//For values which has text for each value
	,float32			//For decimal numbers 32bit precision
) BYTE; END_TYPE
