{
  "external": false, 
  "exclude_from_build": false
}
!__DECLARATION__!
TYPE ESysType :
(
//Bit
	tBOOL		:= 0,
	tBIT		:= 1,
//WORD
	tBYTE		:= 2,
	tWORD		:= 3,
	tDWORD		:= 4,
	tLWORD		:= 5,
//INT
	tSINT		:= 6,
	tINT		:= 7,
	tDINT		:= 8,
	tLINT		:= 9,
//UINT
	tUSINT		:= 10,
	tUINT		:= 11,
	tUDINT		:= 12,
	tULINT		:= 13,
//REAL
	tREAL		:= 14,
	tLREAL		:= 15,
//STRING
	tSTRING		:= 16,
	tWSTRING	:= 17,
//TIME
	tTIME		:= 18,
	tDATE		:= 19,
	tDT			:= 20,
	tTOD		:= 21,
//Special
	tPOINTER	:= 22,
	tREFERENCE	:= 23,
	tSUBRANGE	:= 24,
	tENUM		:= 25,
	tARRAY		:= 26,
	tPARAMS		:= 27,
	tUSERDEF	:= 28,
	tNONE		:= 29,
	tANY		:= 30,
	tANYBIT		:= 31,
	tANYDATE	:= 32,
	tANYINT		:= 33,
	tANYNUM		:= 34,
	tANYREAL	:= 35,
	tLAZY		:= 36,
//LTime
	tLTIME		:= 37,
//Special
	tBITCONST	:= 38
) BYTE;
END_TYPE
