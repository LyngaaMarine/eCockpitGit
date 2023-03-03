//This calls the event which this module was registered for
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 26-11-20 | Creation
METHOD SYS_callEvent : SLMResult
VAR_INPUT
	eventCaller		:POINTER TO FB_Module;	//The module calling the event
	eventType		:WORD;					//Event type id
	eventData		:POINTER TO USysTypes;	//Generic reference to event data, specified by each module
END_VAR
(*%!%__DELIMITER__%!%*)
