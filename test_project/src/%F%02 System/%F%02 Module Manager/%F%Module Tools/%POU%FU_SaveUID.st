//This function takes module id and returns the uid for
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 20-09-20 | Creation
FUNCTION FU_SaveUID
VAR_INPUT
	saver		:ITF_StructWriterBase;
	modID		:AModuleUID;
END_VAR


(*%!%__DELIMITER__%!%*)
saver.writeDint(value:=FU_GetModuleUID(modID:=modID));