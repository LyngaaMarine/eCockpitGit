{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This allocates the needed size for the array
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            
// | 1         | NSN      | 24-11-20 | Creation                                                                                                              
FUNCTION FU_dynamicArrayTransfer : BOOL
VAR_INPUT
	oldArray		:POINTER TO BYTE;
	newArray		:POINTER TO BYTE;
	oldSize			:WORD;
	newSize			:WORD;
END_VAR
VAR
	smallest		:DINT;
	i				:DINT;
END_VAR
!__IMPLEMENTATION__!
smallest			:=		MIN(oldSize,newSize);
FOR i := 1 TO smallest DO
	newArray^		:=		oldArray^;
	newArray		:=		newArray + 1;
	oldArray		:=		oldArray + 1;
END_FOR