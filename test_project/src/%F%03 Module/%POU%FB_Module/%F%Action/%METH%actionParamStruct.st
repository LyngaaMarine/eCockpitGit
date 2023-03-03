//This method lists all available actions for the module using the structure example below
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-08-21 | Creation
METHOD actionParamStruct
VAR_INPUT
	writer		:ITF_StructWriterBase;
END_VAR
(*%!%__DELIMITER__%!%*)
//First a key with the id number of the action is added
writer.addKey(name:=GTSmall.Szero);
writer.objectStart(singleLine:=TRUE);
	//Name of action is added to struct max 40 chars
	writer.addKey(name:=GTSmall.Sname);
	writer.writeString(value:=GTSmall.Sexample);
	//A brief description of the action of 200 chars or less, remember max transmission size before writing long descriptions
	writer.addKey(name:=GTSmall.Sdesc);
	writer.writeString(value:=ADR(''));
	//A list of parameters to pass to the action, leave undefined if no parameters are needed
	writer.addKey(name:=GTSmall.Sparams);
	writer.arrayStart(singleLine:=TRUE);
		//Each parameter is described with an object
		writer.objectStart(singleLine:=TRUE);
			//Name of parameter
			writer.addKey(name:=GTSmall.Sname);
			writer.writeString(value:=GTSmall.Sexample);
			//A brief description of the action of 200 chars or less, remember max transmission size before writing long descriptions
			writer.addKey(name:=GTSmall.Sdesc);
			writer.writeString(value:=ADR(''));
			//Type of parameter data following EActionParamTypes
			writer.addKey(name:=GTSmall.Stype);
			writer.writeDword(value:=EActionParamTypes.tBool);
		writer.structEnd();
	writer.structEnd();
writer.structEnd();