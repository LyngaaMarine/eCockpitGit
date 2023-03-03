{"exclude_from_build": false, "link_always": false}
//This is the textlist file for the system, texts are added here and refered to in the code, this is read only
//The variable name is the same as the text, prefixed with a big N, and without spaces
{attribute 'qualified_only'}
{attribute 'global_init_slot' := '1'}
VAR_GLOBAL
	//A
	Nadmin						:POINTER TO STRING(5)	:=	ADR('Admin');
	NadminGroup					:POINTER TO STRING(11)	:=	ADR('Admin Group');
	NalarmSystem				:POINTER TO STRING(12)	:=	ADR('Alarm System');
	//C
	NclientWebServer			:POINTER TO STRING(17)	:=	ADR('Client/Web Server');
	//G
	NgeneralIO					:POINTER TO STRING(12)	:=	ADR('General I/O');
	//L
	NlicenseSystem				:POINTER TO STRING(12)	:=	ADR('License System');
	NlocalIOCards				:POINTER TO STRING(14)	:=	ADR('Local IO Cards');
	//P
	Nparent						:POINTER TO STRING(4)	:=	ADR('$$par');
	//S	
	NserialPort					:POINTER TO STRING(11)	:=	ADR('Serial Port');
	NsmsModule					:POINTER TO STRING(10)	:=	ADR('SMS Module');
	NsystemAlarms				:POINTER TO STRING(13)	:=	ADR('System Alarms');
	NsystemPLC					:POINTER TO STRING(10)	:=	ADR('System PLC');
	//U
	Nuser						:POINTER TO STRING(4)	:=	ADR('User');
	NuserGroup					:POINTER TO STRING(9)	:=	ADR('UserGroup');
	NuserManager				:POINTER TO STRING(5)	:=	ADR('User manager');
END_VAR