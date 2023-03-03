//This is the textlist file for the system units, texts are added here and refered to in the code, this is read only
//The variable name is the same as the text, prefixed with a big U and without spaces
{attribute 'qualified_only'}
{attribute 'global_init_slot' := '1'}
VAR_GLOBAL
	//C
	Ucelsius					:POINTER TO STRING(3)	:=	ADR('Â°C');
	//D
	Udays						:POINTER TO STRING(1)	:=	ADR('d');
	Udigital					:POINTER TO STRING(3)	:=	ADR('I/O');
	//H
	Uhour						:POINTER TO STRING(1)	:=	ADR('h');
	Uhertz						:POINTER TO STRING(2)	:=	ADR('Hz');
	//M
	UmilliAmp					:POINTER TO STRING(2)	:=	ADR('mA');
	UmilliVolt					:POINTER TO STRING(2)	:=	ADR('mV');
	//O
	Uohm						:POINTER TO STRING(4)	:=	ADR('â„¦');
	//P
	Upercent					:POINTER TO STRING(1)	:=	ADR('%');
	//V
	Uvolt						:POINTER TO STRING(1)	:=	ADR('V');
END_VAR