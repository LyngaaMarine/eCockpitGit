//Method for saving all variables for the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 20-09-20 | Creation
METHOD SYS_saveData
VAR_INPUT
	saver		:ITF_StructWriterBase;
END_VAR
VAR
	i			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
saver.addKey(name:=GTSmall.Sversion);
saver.writeString(value:=ADR(GParameters.softwareVersion));
saver.addKey(name:=GTSmall.Supdate);
saver.writeDint(value:=S_moduleUpdate);