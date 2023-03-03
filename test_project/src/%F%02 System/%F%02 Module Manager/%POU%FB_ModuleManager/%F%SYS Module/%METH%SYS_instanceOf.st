{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD SYS_instanceOf : BOOL
VAR_INPUT
	des			:AModuleDes;
END_VAR

!__IMPLEMENTATION__!
IF des = GMod.DesModuleManager THEN
	SYS_instanceOf			:=		TRUE;
ELSE
	SYS_instanceOf			:=		SUPER^.SYS_instanceOf(des:=des);
END_IF