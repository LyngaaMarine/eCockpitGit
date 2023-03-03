{"exclude_from_build": false, "link_always": false}
{attribute 'qualified_only'}
VAR_GLOBAL
END_VAR
(*
//Type Casting is possible
Getting value
value := __CAST(variable,Type);
Setting value
__CAST(variable,Type) := value;
Function Block
__CAST(variable,Function Block Type).value;
Function Block Method
__CAST(variable,Function Block Type).method();

Union variables can have default values by using the var:=(unionMemberName:=value) trick

Thread safe skip, this thread safety makes it so that if two threads access the resource at the same time, the last one will simply skip the action
VAR (Owner)
	block	:DWORD;
END_VAR

IF __COMPARE_AND_SWAP(ADR(block),0,1) THEN
	setValue();
	count			:=		count + 1;
END_IF

Thread safe, this thread safety makes sure that only one thread at a time access a resource, i can intruduce jitter to a calling task if many threads are calling at the same time
VAR (Owner)
	block	:DWORD;
END_VAR

WHILE TRUE DO
	IF __COMPARE_AND_SWAP(ADR(block),0,1) THEN
		doStuff();
		block		:=		0;
		RETURN;
	END_IF
END_WHILE



*)