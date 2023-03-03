//This function sets the bit true from a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-01-19 | Creation
FUNCTION FU_dwBitConv : DWORD
VAR_IN_OUT
	setBit		:BYTE;		//The value to work with
END_VAR
(*%!%__DELIMITER__%!%*)
CASE setBit OF
	0:	FU_dwBitConv.0		:=		TRUE;
	1:	FU_dwBitConv.1		:=		TRUE;
	2:	FU_dwBitConv.2		:=		TRUE;
	3:	FU_dwBitConv.3		:=		TRUE;
	4:	FU_dwBitConv.4		:=		TRUE;
	5:	FU_dwBitConv.5		:=		TRUE;
	6:	FU_dwBitConv.6		:=		TRUE;
	7:	FU_dwBitConv.7		:=		TRUE;
	8:	FU_dwBitConv.8		:=		TRUE;
	9:	FU_dwBitConv.9		:=		TRUE;
	10:	FU_dwBitConv.10		:=		TRUE;
	11:	FU_dwBitConv.11		:=		TRUE;
	12:	FU_dwBitConv.12		:=		TRUE;
	13:	FU_dwBitConv.13		:=		TRUE;
	14:	FU_dwBitConv.14		:=		TRUE;
	15:	FU_dwBitConv.15		:=		TRUE;
	16:	FU_dwBitConv.16		:=		TRUE;
	17:	FU_dwBitConv.17		:=		TRUE;
	18:	FU_dwBitConv.18		:=		TRUE;
	19:	FU_dwBitConv.19		:=		TRUE;
	20:	FU_dwBitConv.20		:=		TRUE;
	21:	FU_dwBitConv.21		:=		TRUE;
	22:	FU_dwBitConv.22		:=		TRUE;
	23:	FU_dwBitConv.23		:=		TRUE;
	24:	FU_dwBitConv.24		:=		TRUE;
	25:	FU_dwBitConv.25		:=		TRUE;
	26:	FU_dwBitConv.26		:=		TRUE;
	27:	FU_dwBitConv.27		:=		TRUE;
	28:	FU_dwBitConv.28		:=		TRUE;
	29:	FU_dwBitConv.29		:=		TRUE;
	30:	FU_dwBitConv.30		:=		TRUE;
	31:	FU_dwBitConv.31		:=		TRUE;
END_CASE