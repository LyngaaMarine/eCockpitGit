METHOD setAmountSamples : SLMResult
VAR_INPUT
	bAmountSamples		:BYTE;
END_VAR
VAR
	amountBytes			:UDINT;
	samplesBuffer		:POINTER TO ARRAY[0..255] OF DINT;
	samplesDelete		:POINTER TO ARRAY[0..255] OF DINT;
	i					:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
IF amountSamples <> bAmountSamples THEN
	amountBytes						:=		4 * bAmountSamples;
	samplesBuffer					:=		__NEW(BYTE,amountBytes);
	IF samplesBuffer = 0 THEN
		setAmountSamples.success	:=		FALSE;
		setAmountSamples.code		:=		ERCodes.FB_diSampleFilter_setAmountSamples;
		setAmountSamples.reason		:=		GTErrors.EoutOfDynamicMemory;
		RETURN;
	END_IF
	IF bAmountSamples < amountSamples THEN
		IF samples <> 0 THEN
			FOR i := 0 TO bAmountSamples - 1 DO
				samplesBuffer[i]	:=		samples[i];
			END_FOR
		END_IF
		samplesDelete			:=		samples;
		samples					:=		samplesBuffer;
		__DELETE(samplesDelete);
		FU_bMinMaxValue(Variable:=position,MinVal:=0,MaxVal:=bAmountSamples - 1);
	ELSE
		IF samples <> 0 THEN
			FOR i := 0 TO amountSamples - 1 DO
				samplesBuffer[i]	:=		samples[i];
			END_FOR
		END_IF
		samplesDelete			:=		samples;
		samples					:=		samplesBuffer;
		__DELETE(samplesDelete);
		position				:=		amountSamples;
	END_IF
	amountSamples				:=		bAmountSamples;
END_IF