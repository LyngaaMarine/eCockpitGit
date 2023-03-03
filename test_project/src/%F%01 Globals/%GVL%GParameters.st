{attribute 'qualified_only'}
VAR_GLOBAL CONSTANT
//#####		Software Version Number
	softwareVersion					:STRING(100) := '3.1.9';

	maxModules						:AModuleUID := 20000;
//#####		The amount of bytes in the read write buffer
	readWriteBuffer					:WORD := 10000;
//#####		This is the ip address start, which is used when nothing can be retrieved by the plc manager
	ipAddressFallBack				:STRING(12)	:=	'192.168.1.';
//#####		Access Manager
	//This is the amount of time in seconds which passes from the last login event until the system is automatically logged out
	autoLogoutTimeAmount			:DWORD := 86400;
//#####		Alarm System Parameters
	maxAlarmEventsPerCycle			:WORD(1..500)	:= 8;	
	alarmSyncPerCycle				:BYTE(1..200)	:= 50;
	maxAlarmLists					:BYTE(1..200)	:= 20;

//#####		Conditions
	maxSubConditions				:BYTE(1..20) := 10;	//Maximum amount of subconditions in a condition

//#####		Data server 
	amountSettingsClients			:WORD	:=	2;		//The amount of settings clients, actual amount is one higher
	maxDataClients					:WORD(1..30)	:=	19;		//The absoloute maximum amount of data clients
	dataServerMaxCyclicValues		:WORD	:=	150;	//The maximum amount of different module values which can be automatically retrieved
END_VAR