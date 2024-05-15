{
  "exclude_from_build": false, 
  "link_always": false
}
!__DECLARATION__!
//This is the textlist file for the system error messages, texts are added here and refered to in the code, this is read only
//The variable name is the same as the text, prefixed with a big E and without spaces
{attribute 'qualified_only'}
{attribute 'global_init_slot' := '1'}
VAR_GLOBAL
	//A
	EaddressAlreadyRegistered	:POINTER TO STRING(21)	:=	ADR('Address already registered');
	EarrayFull					:POINTER TO STRING(13)	:=	ADR('Array is full');
	//C
	EcommandNotFound			:POINTER TO STRING(17)	:=	ADR('Command not found');
	//D
	EdataNotFound				:POINTER TO STRING(14)	:=	ADR('Data not found');
	EdirectoryDoesntExist		:POINTER TO STRING(23)	:=	ADR('Directory doesn$'t exist');
	//E
	EelementInArray				:POINTER TO STRING(16)	:=	ADR('Element in array');
	//F
	EfileDoesntExist			:POINTER TO STRING(18)	:=	ADR('File Doesn$'t exist');
	//G
	EgeneralFailure				:POINTER TO STRING(15)	:=	ADR('General failure');
	//I
	EindexOutOfRange			:POINTER TO STRING(18)	:=	ADR('Index out of range');
	EinvalidModuleID			:POINTER TO STRING(17)	:=	ADR('Invalid Module ID');
	EinvalidPointer				:POINTER TO STRING(15)	:=	ADR('Invalid pointer');
	EinvalidSpeed				:POINTER TO STRING(13)	:=	ADR('Invalid speed');
	EinvalidValue				:POINTER TO STRING(13)	:=	ADR('Invalid value');
	//M
	EmaxSizeExceeded			:POINTER TO STRING(17)	:=	ADR('Max size exceeded');
	EmaxSubmodulesReached		:POINTER TO STRING(22)	:=	ADR('Max submodules reached');
	EmessageIDNotFound			:POINTER TO STRING(20)	:=	ADR('Message ID not found');
	EmoduleAlreadyRegistered	:POINTER TO STRING(25)	:=	ADR('Module already registered');
	EmoduleUIDNotFound			:POINTER TO STRING(20)	:=	ADR('Module UID not found');
	EmissingInputVars			:POINTER TO STRING(22)	:=	ADR('Missing input variable');
	//N
	EnameNotWritable			:POINTER TO STRING(18)	:=	ADR('Name not writeable');
	EnoMoreIdsAvailable			:POINTER TO STRING(25)	:=	ADR('No more ids are available');
	EnoMoreUIDsAvailable		:POINTER TO STRING(26)	:=	ADR('No more UIDs are available');
	EnotDynamicMemory			:POINTER TO STRING(18)	:=	ADR('Not dynamic memory');				//Fixed memory was used where dynamic was expected
	EnoModuleProvided			:POINTER TO STRING(18)	:=	ADR('No module provided');				//No module provided for functionality
	//O
	EoutOfDynamicMemory			:POINTER TO STRING(21)	:=	ADR('Out of dynamic memory');
	//P
	EpathIsDir					:POINTER TO STRING(11)	:=	ADR('Path is dir');
	EpathIsFile					:POINTER TO STRING(12)	:=	ADR('Path is file');
	EpathMissing				:POINTER TO STRING(12)	:=	ADR('Path missing');
	EpingNotRecieved			:POINTER TO STRING(17)	:=	ADR('Ping not recieved');
	EpointerAlreadyRegistered	:POINTER TO STRING(26)	:=	ADR('Pointer already registered');
	//R
	EresourceInUse				:POINTER TO STRING(15)	:=	ADR('Resource in use');
	ErequestSizeTooBig			:POINTER TO STRING(20)	:=	ADR('Request size too big');
	//S
	EsettingsNotChanged			:POINTER TO STRING(20)	:=	ADR('Settings not changed');
	EsourceDirDontExist			:POINTER TO STRING(22)	:=	ADR('Source dir don$'t exist');
	EsourceFileDontExist		:POINTER TO STRING(23)	:=	ADR('Source file don$'t exist');
	//U
	EunitNotWritable			:POINTER TO STRING(18)	:=	ADR('Unit not writeable');
	EunknownDesignator			:POINTER TO STRING(18)	:=	ADR('Unknown designator');
	//W
	EwrongModuleType			:POINTER TO STRING(17)	:=	ADR('Wrong module type');
	EwrongVariableType			:POINTER TO STRING(19)	:=	ADR('Wrong variable type');
	EwrongDataType				:POINTER TO STRING(15)	:=	ADR('Wrong data type');
	//Q
	EqueueFull					:POINTER TO STRING(13)	:=	ADR('Queue is full');
END_VAR