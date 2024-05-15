{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This ends the previously started object
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 22-06-20 | Creation
METHOD structEnd : BOOL

!__IMPLEMENTATION__!
structEnd		:=		writer.structEnd();
IF doLogInt THEN
	IF logCorrection > 0 THEN
		logCorrection		:=		logCorrection - 1;
	ELSE
		reader.exitObjectArray();
	END_IF
END_IF