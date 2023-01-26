PROGRAM prg_test_1
VAR
	testVar1:BOOL;
	testVar2:INT;
	testVar3:STRING;
	
	alias1		:alias_test;
	enum1		:enum_test;
	struct1		:struct_test;
	union1		:union_test;
END_VAR

(*%!%__DELIMITER__%!%*)
IF testVar1 THEN
	testVar2		:=		44;
END_IF

testVar3[4]			:=		testVar2;