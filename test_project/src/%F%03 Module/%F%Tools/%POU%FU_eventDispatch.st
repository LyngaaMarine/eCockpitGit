{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Function to dispatch an event to an array of modules
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 18-03-22 | Creation
FUNCTION FU_eventDispatch : BOOL
VAR_IN_OUT
	arrayHandler		:FB_DynamicArray;		//Handler for array storing events
END_VAR
VAR_INPUT
	caller				:AModule;				//Module dispatching event
	eventType			:WORD;					//Event type id
	eventData			:POINTER TO BYTE;		//Generic reference to event data, specified by each module
END_VAR
VAR
	i					:WORD;
	modules				:POINTER TO ARRAY[0..99] OF AModule;
END_VAR
!__IMPLEMENTATION__!
IF arrayHandler.S_lenght > 0 THEN
	modules					:=		arrayHandler.getArray;
	FOR i := 0 TO arrayHandler.S_lenght - 1 DO
		modules^[i]^.SYS_callEvent(eventCaller:=caller,eventType:=eventType,eventData:=eventData);
	END_FOR
END_IF