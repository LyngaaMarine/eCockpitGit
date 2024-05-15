{
  "external": false, 
  "exclude_from_build": false
}
!__DECLARATION__!
TYPE USysTypes :
UNION
	bBOOL		:BOOL;
//BYTES
	//Bit not supported
	bBYTE		:BYTE;
	bWORD		:WORD;
	bDWORD		:DWORD;
	bLWORD		:LWORD;
//Integers
	bSINT		:SINT;
	bINT		:INT;
	bDINT		:DINT;
	bLINT		:LINT;
//Unsigned Integers
	bUSINT		:USINT;
	bUINT		:UINT;
	bUDINT		:UDINT;
	bULINT		:ULINT;
//Reals
	bREAL		:REAL;
	bLREAL		:LREAL;
//Strings
	bSTRING		:STRING(80);
	//bWSTRING	:WSTRING(80);
//Time
	bTIME		:TIME;
	bDATE		:DATE;
	bDT			:DT;
	bTOD		:TOD;
//Spectial
	//Pointer not supported
	//Reference not supported
	//Subrange not supported
	//Enumreation not supported
	//Array not supported
	bPOINTER	:POINTER TO BYTE;
	//Userdef not supported
	//None not supported
	//Any not supported
	//Anybit not supported
	//Anydate not supported
	//Anyint not supported
	//Anynum not supported
	//Anyreal not supported
	//Lazy not supported
	bLTIME		:LTIME;
END_UNION
END_TYPE
