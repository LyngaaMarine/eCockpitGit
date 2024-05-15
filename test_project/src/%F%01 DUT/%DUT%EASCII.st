{
  "external": false, 
  "exclude_from_build": false
}
!__DECLARATION__!
{attribute 'qualified_only'}
TYPE EASCII :
(
//####	0-31
	Null		:= 0,		//The utf8 code for null
	SOH			:= 1,		//The utf8 code for start of heading
	STX			:= 2,		//The utf8 code for start of text
	ETX			:= 3,		//The utf8 code for end of text
	EOT			:= 4,		//The utf8 code for end of transmission
	ENQ			:= 5,		//The utf8 code for enquiry
	ACK			:= 6,		//The utf8 code for acknowledge
	BEL			:= 7,		//The utf8 code for bell
	BS			:= 8,		//The utf8 code for backspace
	Tab			:= 9,		//The utf8 code for vertical tab
	LF			:= 10,		//The utf8 code for line feed
	VT			:= 11,		//The utf8 code for vertical tab
	FF			:= 12,		//The utf8 code for form feed/new page
	CR			:= 13,		//The utf8 code for carriage return
	SO			:= 14,		//The utf8 code for shift out
	SI			:= 15,		//The utf8 code for shift in
	DLE			:= 16,		//The utf8 code for data link escape
	DC1			:= 17,		//The utf8 code for device control 1
	DC2			:= 18,		//The utf8 code for device control 2
	DC3			:= 19,		//The utf8 code for device control 3
	DC4			:= 20,		//The utf8 code for device control 4
	NAK			:= 21,		//The utf8 code for negative acknowledge
	SYN			:= 22,		//The utf8 code for synchronous idle
	ETB			:= 23,		//The utf8 code for end of trans. block
	CAN			:= 24,		//The utf8 code for cancel
	EM			:= 25,		//The utf8 code for end of mediom
	SUBB		:= 26,		//The utf8 code for substitute
	ESC			:= 27,		//The utf8 code for escape
	FS			:= 28,		//The utf8 code for file seperator
	GS			:= 29,		//The utf8 code for group seperator
	RS			:= 30,		//The utf8 code for record separator
	US			:= 31,		//The utf8 code for unit seperator
//####	32-63
	Space		:= 32,		//The utf8 code for space
	Exclamation	:= 33,		//The utf8 code for !
	DoubleQoute	:= 34,		//The utf8 code for "
	Hash		:= 35,		//The utf8 code for #
	Dollar		:= 36,		//The utf8 code for $
	Perc		:= 37,		//The utf8 code for %
	Ampersand	:= 38,		//The utf8 code for &
	Apostrophe	:= 39,		//The utf8 code for '
	OpenBracket	:= 40,		//The utf8 code for (
	CloseBracket:= 41,		//The utf8 code for )
	Asterisk	:= 42,		//The utf8 code for *
	Plus		:= 43,		//The utf8 code for +
	Comma		:= 44,		//The utf8 code for ,
	Minus		:= 45,		//The utf8 code for -
	Dot			:= 46,		//The utf8 code for .
	Solidus		:= 47,		//The utf8 code for /, slash
	Zero		:= 48,		//The utf8 code for 0
	One			:= 49,		//The utf8 code for 1
	Two			:= 50,		//The utf8 code for 2
	Three		:= 51,		//The utf8 code for 3
	Four		:= 52,		//The utf8 code for 4
	Five		:= 53,		//The utf8 code for 5
	Six			:= 54,		//The utf8 code for 6
	Seven		:= 55,		//The utf8 code for 7
	Eight		:= 56,		//The utf8 code for 8
	Nine		:= 57,		//The utf8 code for 9
	Colon		:= 58,		//The utf8 code for :
	SemiColon	:= 59,		//The utf8 code for ;
	LessThan	:= 60,		//The utf8 code for <
	Equal		:= 61,		//The utf8 code for =
	GreatThan	:= 62,		//The utf8 code for >
	Question	:= 63,		//The utf8 code for ?, wat
//####	64-95
	Addd		:= 64,		//The utf8 code for @
	BigA		:= 65,		//The utf8 code for A
	BigB		:= 66,		//The utf8 code for B
	BigC		:= 67,		//The utf8 code for C
	BigD		:= 68,		//The utf8 code for D
	BigE		:= 69,		//The utf8 code for E
	BigF		:= 70,		//The utf8 code for F
	BigG		:= 71,		//The utf8 code for G
	BigH		:= 72,		//The utf8 code for H
	BigI		:= 73,		//The utf8 code for I
	BigJ		:= 74,		//The utf8 code for J
	BigK		:= 75,		//The utf8 code for K
	BigL		:= 76,		//The utf8 code for L
	BigM		:= 77,		//The utf8 code for M
	BigN		:= 78,		//The utf8 code for N
	BigO		:= 79,		//The utf8 code for O
	BigP		:= 80,		//The utf8 code for P
	BigQ		:= 81,		//The utf8 code for Q
	BigR		:= 82,		//The utf8 code for R
	BigS		:= 83,		//The utf8 code for S
	BigT		:= 84,		//The utf8 code for T
	BigU		:= 85,		//The utf8 code for U
	BigV		:= 86,		//The utf8 code for V
	BigW		:= 87,		//The utf8 code for W
	BigX		:= 88,		//The utf8 code for X
	BigY		:= 89,		//The utf8 code for Y
	BigZ		:= 90,		//The utf8 code for Z
	SqBracketO	:= 91,		//The utf8 code for [
	BackSlash	:= 92,		//The utf8 code for \
	SqBracketC	:= 93,		//The utf8 code for ]
	Caret		:= 94,		//The utf8 code for ^
	Underscore	:= 95,		//The utf8 code for _
//####	96-127
	Grave		:= 96,		//The utf8 code for `
	Smalla		:= 97,		//The utf8 code for a
	Smallb		:= 98,		//The utf8 code for b
	Smallc		:= 99,		//The utf8 code for c
	Smalld		:= 100,		//The utf8 code for d
	Smalle		:= 101,		//The utf8 code for e
	Smallf		:= 102,		//The utf8 code for f
	Smallg		:= 103,		//The utf8 code for g
	Smallh		:= 104,		//The utf8 code for h
	Smalli		:= 105,		//The utf8 code for i
	Smallj		:= 106,		//The utf8 code for j
	Smallk		:= 107,		//The utf8 code for k
	Smalll		:= 108,		//The utf8 code for l
	Smallm		:= 109,		//The utf8 code for m
	Smalln		:= 110,		//The utf8 code for n
	Smallo		:= 111,		//The utf8 code for o
	Smallp		:= 112,		//The utf8 code for p
	Smallq		:= 113,		//The utf8 code for q
	Smallr		:= 114,		//The utf8 code for r
	Smalls		:= 115,		//The utf8 code for s
	Smallt		:= 116,		//The utf8 code for t
	Smallu		:= 117,		//The utf8 code for u
	Smallv		:= 118,		//The utf8 code for v
	Smallw		:= 119,		//The utf8 code for w
	Smallx		:= 120,		//The utf8 code for x
	Smally		:= 121,		//The utf8 code for y
	Smallz		:= 122,		//The utf8 code for z
	OpenBraces	:= 123,		//The utf8 code for { 
	VBar		:= 124,		//The utf8 code for |
	CloseBraces	:= 125,		//The utf8 code for }
	Tilde		:= 126,		//The utf8 code for ~
	DEL			:= 127		//The utf8 code for delete
) BYTE;
END_TYPE
