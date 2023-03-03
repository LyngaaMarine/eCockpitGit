METHOD SYS_instanceOf : BOOL
VAR_INPUT
	des			:AModuleDes;
END_VAR

(*%!%__DELIMITER__%!%*)
IF des = GMod.DesModuleManager THEN
	SYS_instanceOf			:=		TRUE;
ELSE
	SYS_instanceOf			:=		SUPER^.SYS_instanceOf(des:=des);
END_IF