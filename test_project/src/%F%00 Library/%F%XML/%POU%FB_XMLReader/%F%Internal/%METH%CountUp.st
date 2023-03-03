{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method is used to count up the address of the cursor
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD PROTECTED CountUp :BOOL;
!__IMPLEMENTATION__!
IF ADRCursor < FileBufferMaxADR - 1 THEN
	ADRCursor				:=		ADRCursor + 1;			//Cursor increased by one
	CountUp					:=		TRUE;
	IF ADRCursor^ = EASCII.LessThan THEN
		ADRCursor			:=		ADRCursor + 1;			//Cursor increased by one
		IF ADRCursor^ = EASCII.Solidus THEN					//At end tag it counts down the layer
			TreeLevel		:=		TreeLevel - 1;
		ELSIF ADRCursor^ = EASCII.Exclamation THEN			//At end tag it counts down the layer
			;
		ELSIF ADRCursor^ = EASCII.Question THEN				//At end tag it counts down the layer
			;
		ELSE												//At start tag it counts up the layer
			TreeLevel		:=		TreeLevel + 1;
		END_IF
		ADRCursor			:=		ADRCursor - 1;			//Cursor increased by one
	END_IF
	IF ADRCursor^ = EASCII.Solidus THEN
		ADRCursor			:=		ADRCursor + 1;			//Cursor increased by one
		IF ADRCursor^ = EASCII.GreatThan THEN				//At end tag it counts down the layer
			TreeLevel		:=		TreeLevel - 1;
		END_IF
		ADRCursor			:=		ADRCursor - 1;			//Cursor increased by one
	END_IF
END_IF

