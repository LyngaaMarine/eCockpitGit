{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 19-05-20 | Creation
METHOD PROTECTED pmb
VAR
	k			:ARRAY[0..3] OF DWORD := [16#5A827999,16#6ED9EBA1,16#8F1BBCDC,16#CA62C1D6];
	t			:INT;
	temp		:DWORD;
	w			:ARRAY[0..79] OF DWORD;
	a,b,c,d,e	:DWORD;
END_VAR
!__IMPLEMENTATION__!
FOR t := 0 TO 15 DO
	w[t]	:=		SHL(TO_DWORD(block[t * 4]),24);
	w[t]	:=		w[t] OR SHL(TO_DWORD(block[t * 4 + 1]),16);
	w[t]	:=		w[t] OR SHL(TO_DWORD(block[t * 4 + 2]),8);
	w[t]	:=		w[t] OR block[t * 4 + 3];
END_FOR
FOR t := 16 TO 79 DO
	w[t]	:=		ROL(w[t - 3] XOR w[t - 8] XOR w[t - 14] XOR w[t - 16],1);
END_FOR
a			:=		hash[0];
b			:=		hash[1];
c			:=		hash[2];
d			:=		hash[3];
e			:=		hash[4];

FOR t := 0 TO 19 DO
	temp	:=		ROL(a,5) + ((b AND c) OR (NOT(b) AND d)) + e + w[t] + k[0];
	e		:=		d;
	d		:=		c;
	c		:=		ROL(b,30);
	b		:=		a;
	a		:=		temp;
END_FOR

FOR t := 20 TO 39 DO
	temp	:=		ROL(a,5) + (b XOR c XOR d) + e + w[t] + k[1];
	e		:=		d;
	d		:=		c;
	c		:=		ROL(b,30);
	b		:=		a;
	a		:=		temp;
END_FOR

FOR t := 40 TO 59 DO
	temp	:=		ROL(a,5) + ((b AND c) OR (b AND d) OR (c AND d)) + e + w[t] + k[2];
	e		:=		d;
	d		:=		c;
	c		:=		ROL(b,30);
	b		:=		a;
	a		:=		temp;
END_FOR

FOR t := 60 TO 79 DO
	temp	:=		ROL(a,5) + (b XOR c XOR d) + e + w[t] + k[3];
	e		:=		d;
	d		:=		c;
	c		:=		ROL(b,30);
	b		:=		a;
	a		:=		temp;
END_FOR

hash[0]		:=		hash[0] + a;
hash[1]		:=		hash[1] + b;
hash[2]		:=		hash[2] + c;
hash[3]		:=		hash[3] + d;
hash[4]		:=		hash[4] + e;

index		:=		0;