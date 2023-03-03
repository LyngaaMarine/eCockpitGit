{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Performs the conversion of a module value to a 3 point calibrated value
//Returns if the value is valid and the converted value
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
FUNCTION FU_moduleValue3PointToReal : EValueValidity
VAR_OUTPUT
	value			:REAL;		//Converted value
END_VAR
VAR_INPUT
	outMin			:REAL;		//Minimum value of calibration (point 1)
	outMid			:REAL;		//Middle value of calibration (point 2)
	outMax			:REAL;		//Maximum value of calibration (point 3)
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
	FU_moduleValue3PointToReal			:=		module^.SYS_isValid;
	IF FU_moduleValue3PointToReal = EValueValidity.valid THEN
		CASE module^.SYS_valueType OF
			EValueType.digital:
				IF module^.SYS_valueDigital THEN
					value				:=		outMax;
				ELSE
					value				:=		outMid;
				END_IF
			EValueType.float32:
				value					:=		FU_rLinear3(XIn:=module^.SYS_valueFloat32,X1:=data.minValue.float32,X2:=data.midValue.float32,X3:=data.maxValue.float32,Y1:=outMin,Y2:=outMid,Y3:=outMax);
			EValueType.signed32,EValueType.enum:
				value					:=		FU_rLinear3(XIn:=TO_REAL(module^.SYS_valueSigned32),X1:=data.minValue.float32,X2:=data.midValue.float32,X3:=data.maxValue.float32,Y1:=outMin,Y2:=outMid,Y3:=outMax);
			EValueType.signed64:
				value					:=		FU_rLinear3(XIn:=TO_REAL(module^.SYS_valueSigned64),X1:=data.minValue.float32,X2:=data.midValue.float32,X3:=data.maxValue.float32,Y1:=outMin,Y2:=outMid,Y3:=outMax);
			EValueType.unsigned32:
				value					:=		FU_rLinear3(XIn:=TO_REAL(module^.SYS_valueUnsigned32),X1:=data.minValue.float32,X2:=data.midValue.float32,X3:=data.maxValue.float32,Y1:=outMin,Y2:=outMid,Y3:=outMax);
			EValueType.unsigned64:		
				value					:=		FU_rLinear3(XIn:=TO_REAL(module^.SYS_valueUnsigned64),X1:=data.minValue.float32,X2:=data.midValue.float32,X3:=data.maxValue.float32,Y1:=outMin,Y2:=outMid,Y3:=outMax);
		END_CASE
	END_IF
ELSE
	FU_moduleValue3PointToReal			:=		EValueValidity.sourceInvalid;
END_IF