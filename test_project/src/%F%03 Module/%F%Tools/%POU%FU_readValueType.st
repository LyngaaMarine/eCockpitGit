{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Reads a value type from a struct
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_readValueType : EValueType
VAR_INPUT
	reader			:ITF_StructReaderBase;	//Reader
END_VAR
VAR
	buffer			:STRING(10);
END_VAR
!__IMPLEMENTATION__!
reader.readString(str:=ADR(buffer),lenMax:=SIZEOF(buffer)-1);
CASE buffer[0] OF
	EASCII.Smalln,EASCII.BigN:		FU_readValueType		:=		EValueType.none;
	EASCII.Smalld,EASCII.BigD:		FU_readValueType		:=		EValueType.digital;
	EASCII.Smalle,EASCII.BigE:		FU_readValueType		:=		EValueType.enum;
	EASCII.Smallf,EASCII.BigF:		FU_readValueType		:=		EValueType.float32;
	EASCII.Smalls,EASCII.BigS:
		CASE buffer[3] OF
			EASCII.Three:			FU_readValueType		:=		EValueType.signed32;
			EASCII.Six:				FU_readValueType		:=		EValueType.signed64;
		ELSE
			CASE buffer[6] OF
				EASCII.Three:		FU_readValueType		:=		EValueType.signed32;
				EASCII.Six:			FU_readValueType		:=		EValueType.signed64;	
			END_CASE	
		END_CASE
	EASCII.Smallu,EASCII.BigU:
		CASE buffer[3] OF
			EASCII.Three:			FU_readValueType		:=		EValueType.unsigned32;
			EASCII.Six:				FU_readValueType		:=		EValueType.unsigned64;
		ELSE
			CASE buffer[6] OF
				EASCII.Three:		FU_readValueType		:=		EValueType.unsigned32;
				EASCII.Six:			FU_readValueType		:=		EValueType.unsigned64;	
			END_CASE	
		END_CASE
END_CASE