//This method tells the data client how many bytes should be reserved for this command controller, for keeping track of states and such
METHOD dtsReserveData : WORD
(*%!%__DELIMITER__%!%*)
dtsReserveData		:=		SIZEOF(SModManDataClientData);