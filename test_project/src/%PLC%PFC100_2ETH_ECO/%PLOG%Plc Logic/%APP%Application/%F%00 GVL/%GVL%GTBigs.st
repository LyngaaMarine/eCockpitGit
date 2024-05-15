{
  "exclude_from_build": false, 
  "link_always": false
}
!__DECLARATION__!
//This is the textlist file for the system, texts are added here and refered to in the code, this is read only
//This list contains texts starting with a big character
{attribute 'qualified_only'}
{attribute 'global_init_slot' := '1'}
VAR_GLOBAL
	//N
	BNaN						:POINTER TO STRING(3)	:=	ADR('NaN');
	//I
	BInf						:POINTER TO STRING(3)	:=	ADR('Inf');
	//-
	BminusInf					:POINTER TO STRING(4)	:=	ADR('-Inf');
END_VAR