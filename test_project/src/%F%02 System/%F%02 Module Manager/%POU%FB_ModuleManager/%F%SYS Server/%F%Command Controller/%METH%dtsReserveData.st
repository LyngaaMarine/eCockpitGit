{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method tells the data client how many bytes should be reserved for this command controller, for keeping track of states and such
METHOD dtsReserveData : WORD
!__IMPLEMENTATION__!
dtsReserveData		:=		SIZEOF(SModManDataClientData);