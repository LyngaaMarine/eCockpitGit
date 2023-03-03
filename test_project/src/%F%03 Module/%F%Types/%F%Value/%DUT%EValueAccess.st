{"external": false, "exclude_from_build": false}
{attribute 'qualified_only'}
{attribute 'strict'}
//This contains all the different types of values
TYPE EValueAccess :(
	none		,		//No value
	input		,		//Input or reading only
	output				//Output or read + writing
) BYTE; END_TYPE
