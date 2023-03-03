{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Performs the conversion of a module value to a 3 point calibrated value
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
FUNCTION FU_moduleValue3PointFromReal : BOOL
VAR_INPUT
	value			:REAL;		//Value to convert value
	inMin			:REAL;		//Minimum value of calibration (point 1)
	inMid			:REAL;		//Middle value of calibration (point 2)
	inMax			:REAL;		//Maximum value of calibration (point 3)
END_VAR
VAR_IN_OUT
	data			:SModuleValueConversion3Point;	//3 Point conversion struct
END_VAR
VAR
	module			:AModule;
	valueType		:EValueType;
END_VAR

!__IMPLEMENTATION__!
module									:=		GMod.modMan.getModuleByUID(modUID:=data.moduleUID);
IF module <> 0 THEN
	CASE module^.SYS_valueType OF
		EValueType.digital:
			module^.SYS_valueDigital	:=		value <> inMid;
		EValueType.float32:
			module^.SYS_valueFloat32	:=		FU_rLinear3(XIn:=value,X1:=inMin,X2:=inMid,X3:=inMax,Y1:=data.minValue.float32,Y2:=data.midValue.float32,Y3:=data.maxValue.float32);
		EValueType.signed32,EValueType.enum:
			module^.SYS_valueSigned32	:=		TO_DINT(FU_rLinear3(XIn:=value,X1:=inMin,X2:=inMid,X3:=inMax,Y1:=data.minValue.float32,Y2:=data.midValue.float32,Y3:=data.maxValue.float32));
		EValueType.signed64:
			module^.SYS_valueSigned64	:=		TO_LINT(FU_rLinear3(XIn:=value,X1:=inMin,X2:=inMid,X3:=inMax,Y1:=data.minValue.float32,Y2:=data.midValue.float32,Y3:=data.maxValue.float32));
		EValueType.unsigned32:
			module^.SYS_valueUnsigned32	:=		TO_DWORD(FU_rLinear3(XIn:=value,X1:=inMin,X2:=inMid,X3:=inMax,Y1:=data.minValue.float32,Y2:=data.midValue.float32,Y3:=data.maxValue.float32));
		EValueType.unsigned64:
			module^.SYS_valueUnsigned64	:=		TO_LWORD(FU_rLinear3(XIn:=value,X1:=inMin,X2:=inMid,X3:=inMax,Y1:=data.minValue.float32,Y2:=data.midValue.float32,Y3:=data.maxValue.float32));
	END_CASE
END_IF