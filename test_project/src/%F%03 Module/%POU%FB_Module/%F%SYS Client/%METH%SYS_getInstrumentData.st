//This method writes the values for a dedicated module instrument to a struct
//Values are written as a struct with keys
//Max size of struct must not exceed 400 bytes
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 17-03-22 | Creation
METHOD SYS_getInstrumentData
VAR_INPUT
	client		:POINTER TO FB_DataServerClient;
	writer		:ITF_StructWriterBase;
END_VAR
(*%!%__DELIMITER__%!%*)