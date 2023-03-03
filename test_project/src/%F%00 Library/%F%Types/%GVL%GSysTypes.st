{attribute 'qualified_only'}
//This global variable list contains info about the data types
//It must be used in conjuntion with eSysTypes
//Example, gTypes.Sizes[eSysTypes.BOOL]
VAR_GLOBAL CONSTANT
Sizes : ARRAY[0..56] OF BYTE := [
	1,			//0		BOOL
	0,			//1		BIT
	1,			//2		Byte
	2,			//3		Word
	4,			//4		Dword
	8,			//5		Lword
	1,			//6		Sint
	2,			//7		Int
	4,			//8		Dint
	8,			//9		Lint
	1,			//10	Usint
	2,			//11	Uint
	4,			//12	Udint
	8,			//13	Ulint
	4,			//14	Real
	8,			//15	Lreal
	1,			//16	String
	2,			//17	Wstring
	4,			//18	Time
	4,			//19	Date
	4,			//20	DT
	4,			//21	TOD
	4,			//22	Pointer
	4,			//23	Reference
	0,			//24	Subrange
	0,			//25	Enum
	0,			//26	Array
	0,			//27	Params
	0,			//28	Userdef
	0,			//29	None
	0,			//30	Any
	0,			//31	Anybit
	0,			//32	Anydate
	0,			//33	Anyint
	0,			//34	Anynum
	0,			//35	Anyreal
	0,			//36	Lazy
	8,			//37	Ltime
	8			//38	Bitconst
];
Names : ARRAY[0..56] OF STRING(9) := [
	'BOOL',		//0
	'BIT',		//1
	'BYTE',		//2
	'WORD',		//3
	'DWORD',	//4
	'LWORD',	//5
	'SINT',		//6
	'INT',		//7
	'DINT',		//8
	'LINT',		//9
	'USINT',	//10
	'UINT',		//11
	'UDINT',	//12
	'ULINT',	//13
	'REAL',		//14
	'LREAL',	//15
	'STRING',	//16
	'WSTRING',	//17
	'TIME',		//18
	'DATE',		//19
	'DT',		//20
	'TOD',		//21
	'POINTER',	//22
	'REFERENCE',//23
	'SUBRANGE',	//24
	'ENUM',		//25
	'ARRAY',	//26
	'PARAMS',	//27
	'USERDEF',	//28
	'NONE',		//29
	'ANY',		//30
	'ANYBIT',	//31
	'ANYDATE',	//32
	'ANYINT',	//33
	'ANYNUM',	//34
	'ANYREAL',	//35
	'LAZY',		//36
	'LTIME',	//37
	'BITCONST'	//38
];
END_VAR