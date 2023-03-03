METHOD SYS_instanceOf : BOOL
VAR_INPUT
	des			:AModuleDes;
END_VAR

(*%!%__DELIMITER__%!%*)
IF des = GMod.DesModule THEN
	SYS_instanceOf			:=		TRUE;
END_IF