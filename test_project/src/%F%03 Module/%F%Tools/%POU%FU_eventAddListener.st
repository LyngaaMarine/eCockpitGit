//Function to add a module to listen to an event
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 18-03-22 | Creation
FUNCTION FU_eventAddListener : SLMResult
VAR_IN_OUT
	arrayHandler		:FB_DynamicArray;			//Handler for array storing events
END_VAR
VAR_INPUT
	listener			:AModule;					//Listener to remove
END_VAR
(*%!%__DELIMITER__%!%*)
FU_eventAddListener			:=		arrayHandler.appendElement(element:=ADR(listener),elementSize:=SIZEOF(listener));