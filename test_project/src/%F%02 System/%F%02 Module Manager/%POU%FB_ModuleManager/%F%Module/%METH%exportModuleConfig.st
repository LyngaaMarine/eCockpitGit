{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method is called to generate config object for module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 18-02-22 | Creation
METHOD exportModuleConfig : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	writer		:ITF_StructWriterBase;
END_VAR
!__IMPLEMENTATION__!
IF module^._name <> 0 THEN
	writer.addKey(name:=GTSmall.Sname);
	structWriteModuleName(module:=module,writer:=writer,mode:=1);
END_IF
IF module^._unit <> 0 THEN
	writer.addKey(name:=GTSmall.Sunit);
	writeModuleUnitToStruct(module:=module,writer:=writer,mode:=1);
END_IF
//Info
writer.addKey(name:=GTSmall.Scd);
writer.writeDint(value:=TO_DINT(module^.SYS_canDelete));
writer.addKey(name:=GTSmall.Snt);
writer.writeDint(value:=TO_DINT(module^.SYS_nameWrite));
writer.addKey(name:=GTSmall.Sut);
writer.writeDint(value:=TO_DINT(module^.SYS_unitWrite));
module^.SYS_exportConfig(writer:=writer);