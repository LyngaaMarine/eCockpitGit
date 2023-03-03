{"external": false, "exclude_from_build": false}
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE ETask :(
	AlarmSystem				:=		0,
	Logging					:=		1,
	DataServerFixed			:=		2,
	DataServerClients		:=		3,
	GeneralIO				:=		4,
	LocalIO					:=		5,
	NetworkIO				:=		6,
	ModulesFast				:=		7,
	ModulesSlow				:=		8,
	ModulesSuperSlow		:=		9,


	Management				:=		99
) BYTE;
END_TYPE
