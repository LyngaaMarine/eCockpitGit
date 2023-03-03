{"exclude_from_build": false, "link_always": false}
//This is the textlist file for the system, texts are added here and refered to in the code, this is read only
//The variable name is the same as the text, with a big S for starting with lower case and big B for starting with upper case
{attribute 'qualified_only'}
{attribute 'global_init_slot' := '1'}
VAR_GLOBAL
	//To be changed or removed
	//Text lists
	listAlarmStates				:ARRAY[0..2] OF POINTER TO STRING(5) := [ADR('Clear'),ADR('Trig'),ADR('Ack')];
	listAlarmStatesOneLetter	:ARRAY[0..2] OF POINTER TO STRING(1) := [ADR('C'),ADR('T'),ADR('A')];
	
	//Enums
	onOff						:ARRAY[0..1] OF POINTER TO STRING(3)	:=	[ADR('On'),ADR('Off')];
	passBlockListTypes			:ARRAY[0..2] OF POINTER TO STRING(9)	:=	[ADR('Disabled'),ADR('PassList'),ADR('BlockList')];
	valueInvalidTypes			:ARRAY[0..8] OF POINTER TO STRING(3)	:=	[ADR('OK'),ADR('INV'),ADR('UR'),ADR('OR'),ADR('OL'),ADR('WB'),ADR('SL'),ADR('OOR'),ADR('SI')];
	
	conditionTypes				:ARRAY[0..5] OF POINTER TO STRING(16)	:=	[ADR('Disabled'),ADR('Compare Value'),ADR('Compare 2 Values'),ADR('Compare Modules'),ADR('Compare Valid'),ADR('Module Special')];
	conditionNexts				:ARRAY[0..1] OF POINTER TO STRING(3)	:=	[ADR('And'),ADR('Or')];
	conditionCompareTypes		:ARRAY[0..2] OF POINTER TO STRING(16)	:=	[ADR('A Bigger Than B'),ADR('A Smaller Than B'),ADR('A Equal To B')];
	conditionCompare2Types		:ARRAY[0..1] OF POINTER TO STRING(17)	:=	[ADR('A Between B and C'),ADR('A Outside B and C')];

	structTypes					:ARRAY[0..7] OF POINTER TO STRING(7)	:=	[ADR('None'),ADR('NULL'),ADR('Number'),ADR('Boolean'),ADR('String'),ADR('Object'),ADR('Array'),ADR('Invalid')];
END_VAR