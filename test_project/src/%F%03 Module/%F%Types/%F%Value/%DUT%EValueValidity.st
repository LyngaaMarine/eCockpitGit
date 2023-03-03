{attribute 'qualified_only'}
{attribute 'strict'}
//This contains all the different types of invalid values
TYPE EValueValidity :(
	valid				//Valid values
	,invalid			//Invalid Value
	,underRange			//Value under lowest value
	,overRange			//Value over largest value
	,overLoad			//Value is overloaded
	,wireBreak			//Value has wire break
	,sourceLost			//Source of value is lost
	,outOfRange			//Value is out of range
	,sourceInvalid		//Source of value is invalid/or configured wrong
) BYTE; END_TYPE
