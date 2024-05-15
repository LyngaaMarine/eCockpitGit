{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD PROTECTED MD5_Transform : BOOL
//MD5 basic transformation. Transform state according to first 64 bytes at Buffer
VAR_INPUT
	padwState			:POINTER TO ARRAY[0..3] OF DWORD;
	pBuffer				:POINTER TO BYTE;
END_VAR
VAR
	pdwInput			:POINTER TO DWORD;
	dwA,dwB,dwC,dwD		:DWORD;
	adwX				:ARRAY[0..15] OF DWORD;
END_VAR
!__IMPLEMENTATION__!
MD5_Move(pBuffer,ADR(adwX),64);

dwA				:=		padwState^[0];
dwB				:=		padwState^[1];
dwC				:=		padwState^[2];
dwD				:=		padwState^[3];

//Round 1
dwA				:=		MD5_FF(dwA, dwB, dwC, dwD, adwX[0], 7,16#D76AA478) ;	//1
dwD				:=		MD5_FF(dwD, dwA, dwB, dwC, adwX[1], 12, 16#E8C7B756);	//2
dwC				:=		MD5_FF(dwC, dwD, dwA, dwB, adwX[2], 17, 16#242070DB);	//3
dwB				:=		MD5_FF(dwB, dwC, dwD, dwA, adwX[3], 22, 16#C1BDCEEE);	//4
dwA				:=		MD5_FF(dwA, dwB, dwC, dwD, adwX[4], 7, 16#F57C0FAF);	//5
dwD				:=		MD5_FF(dwD, dwA, dwB, dwC, adwX[5], 12, 16#4787C62A);	//6
dwC				:=		MD5_FF(dwC, dwD, dwA, dwB, adwX[6], 17, 16#A8304613);	//7
dwB				:=		MD5_FF(dwB, dwC, dwD, dwA, adwX[7], 22, 16#FD469501);	//8
dwA				:=		MD5_FF(dwA, dwB, dwC, dwD, adwX[8], 7, 16#698098D8);	//9
dwD				:=		MD5_FF(dwD, dwA, dwB, dwC, adwX[9], 12, 16#8B44F7AF);	//10
dwC				:=		MD5_FF(dwC, dwD, dwA, dwB, adwX[10], 17, 16#FFFF5BB1);	//11
dwB				:=		MD5_FF(dwB, dwC, dwD, dwA, adwX[11], 22, 16#895CD7BE);	//12
dwA				:=		MD5_FF(dwA, dwB, dwC, dwD, adwX[12], 7, 16#6B901122);	//13
dwD				:=		MD5_FF(dwD, dwA, dwB, dwC, adwX[13], 12, 16#FD987193);	//14
dwC				:=		MD5_FF(dwC, dwD, dwA, dwB, adwX[14], 17, 16#A679438E);	//15
dwB				:=		MD5_FF(dwB, dwC, dwD, dwA, adwX[15], 22, 16#49B40821);	//16

//Round 2
dwA				:=		MD5_GG(dwA, dwB, dwC, dwD, adwX[1], 5, 16#F61E2562);	//17
dwD				:=		MD5_GG(dwD, dwA, dwB, dwC, adwX[6], 9, 16#C040B340);	//18
dwC				:=		MD5_GG(dwC, dwD, dwA, dwB, adwX[11], 14, 16#265E5A51);	//19
dwB				:=		MD5_GG(dwB, dwC, dwD, dwA, adwX[0], 20, 16#E9B6C7AA);	//20
dwA				:=		MD5_GG(dwA, dwB, dwC, dwD, adwX[5], 5, 16#D62F105D);	//21
dwD				:=		MD5_GG(dwD, dwA, dwB, dwC, adwX[10], 9,  16#2441453);	//22
dwC				:=		MD5_GG(dwC, dwD, dwA, dwB, adwX[15], 14, 16#D8A1E681);	//23
dwB				:=		MD5_GG(dwB, dwC, dwD, dwA, adwX[4], 20, 16#E7D3FBC8);	//24
dwA				:=		MD5_GG(dwA, dwB, dwC, dwD, adwX[9], 5, 16#21E1CDE6);	//25
dwD				:=		MD5_GG(dwD, dwA, dwB, dwC, adwX[14], 9, 16#C33707D6);	//26
dwC				:=		MD5_GG(dwC, dwD, dwA, dwB, adwX[3], 14, 16#F4D50D87);	//27
dwB				:=		MD5_GG(dwB, dwC, dwD, dwA, adwX[8], 20, 16#455A14ED);	//28
dwA				:=		MD5_GG(dwA, dwB, dwC, dwD, adwX[13], 5, 16#A9E3E905);	//29
dwD				:=		MD5_GG(dwD, dwA, dwB, dwC, adwX[2], 9, 16#FCEFA3F8);	//30
dwC				:=		MD5_GG(dwC, dwD, dwA, dwB, adwX[7], 14, 16#676F02D9);	//31
dwB				:=		MD5_GG(dwB, dwC, dwD, dwA, adwX[12], 20, 16#8D2A4C8A);	//32

//Round 3
dwA				:=		MD5_HH(dwA, dwB, dwC, dwD, adwX[5], 4, 16#FFFA3942);	//33
dwD				:=		MD5_HH(dwD, dwA, dwB, dwC, adwX[8], 11, 16#8771F681);	//34
dwC				:=		MD5_HH(dwC, dwD, dwA, dwB, adwX[11], 16, 16#6D9D6122);	//35
dwB				:=		MD5_HH(dwB, dwC, dwD, dwA, adwX[14], 23, 16#FDE5380C);	//36
dwA				:=		MD5_HH(dwA, dwB, dwC, dwD, adwX[1], 4, 16#A4BEEA44);	//37
dwD				:=		MD5_HH(dwD, dwA, dwB, dwC, adwX[4], 11, 16#4BDECFA9);	//38
dwC				:=		MD5_HH(dwC, dwD, dwA, dwB, adwX[7], 16, 16#F6BB4B60);	//39
dwB				:=		MD5_HH(dwB, dwC, dwD, dwA, adwX[10], 23, 16#BEBFBC70);	//40
dwA				:=		MD5_HH(dwA, dwB, dwC, dwD, adwX[13], 4, 16#289B7EC6);	//41
dwD				:=		MD5_HH(dwD, dwA, dwB, dwC, adwX[0], 11, 16#EAA127FA);	//42
dwC				:=		MD5_HH(dwC, dwD, dwA, dwB, adwX[3], 16, 16#D4EF3085);	//43
dwB				:=		MD5_HH(dwB, dwC, dwD, dwA, adwX[6], 23,  16#4881D05);	//44
dwA				:=		MD5_HH(dwA, dwB, dwC, dwD, adwX[9], 4, 16#D9D4D039);	//45
dwD				:=		MD5_HH(dwD, dwA, dwB, dwC, adwX[12], 11, 16#E6DB99E5);	//46
dwC				:=		MD5_HH(dwC, dwD, dwA, dwB, adwX[15], 16, 16#1FA27CF8);	//47
dwB				:=		MD5_HH(dwB, dwC, dwD, dwA, adwX[2], 23, 16#C4AC5665);	//48

//Round 4
dwA				:=		MD5_II(dwA, dwB, dwC, dwD, adwX[0], 6, 16#F4292244);	//49
dwD				:=		MD5_II(dwD, dwA, dwB, dwC, adwX[7], 10, 16#432AFF97);	//50
dwC				:=		MD5_II(dwC, dwD, dwA, dwB, adwX[14], 15, 16#AB9423A7);	//51
dwB				:=		MD5_II(dwB, dwC, dwD, dwA, adwX[5], 21, 16#FC93A039);	//52
dwA				:=		MD5_II(dwA, dwB, dwC, dwD, adwX[12], 6, 16#655B59C3);	//53
dwD				:=		MD5_II(dwD, dwA, dwB, dwC, adwX[3], 10, 16#8F0CCC92);	//54
dwC				:=		MD5_II(dwC, dwD, dwA, dwB, adwX[10], 15, 16#FFEFF47D);	//55
dwB				:=		MD5_II(dwB, dwC, dwD, dwA, adwX[1], 21, 16#85845DD1);	//56
dwA				:=		MD5_II(dwA, dwB, dwC, dwD, adwX[8], 6, 16#6FA87E4F);	//57
dwD				:=		MD5_II(dwD, dwA, dwB, dwC, adwX[15], 10, 16#FE2CE6E0);	//58
dwC				:=		MD5_II(dwC, dwD, dwA, dwB, adwX[6], 15, 16#A3014314);	//59
dwB				:=		MD5_II(dwB, dwC, dwD, dwA, adwX[13], 21, 16#4E0811A1);	//60
dwA				:=		MD5_II(dwA, dwB, dwC, dwD, adwX[4], 6, 16#F7537E82);	//61
dwD				:=		MD5_II(dwD, dwA, dwB, dwC, adwX[11], 10, 16#BD3AF235);	//62
dwC				:=		MD5_II(dwC, dwD, dwA, dwB, adwX[2], 15, 16#2AD7D2BB);	//63
dwB				:=		MD5_II(dwB, dwC, dwD, dwA, adwX[9], 21, 16#EB86D391);	//64

padwState^[0]	:=		padwState^[0] + dwA;
padwState^[1]	:=		padwState^[1] + dwB;
padwState^[2]	:=		padwState^[2] + dwC;
padwState^[3]	:=		padwState^[3] + dwD;