{attribute 'qualified_only'}
TYPE EModuleFlags :(
	editBlock		:=	0		//Bit 0: Flag for disableing editing of the module
	,loaded			:=	1		//Bit 1: During boot, this flag is used to check if the module has been loaded
) BYTE; END_TYPE
