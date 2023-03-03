//This allows another module to register with a event on this module
//Event type numbers are specified by each module individually
//Event type 0-499 are reserved for shared event types
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 26-11-20 | Creation
METHOD SYS_registerEventListener : SLMResult
VAR_INPUT
	reOrDeregister	:BOOL;		//True is register, false is deregister
	registrant		:POINTER TO FB_Module;	//The module to call when the event happens
	eventType		:WORD;					
END_VAR
(*%!%__DELIMITER__%!%*)
