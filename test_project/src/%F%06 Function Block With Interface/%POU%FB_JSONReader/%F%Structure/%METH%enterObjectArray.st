{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method enters the last found object and sets it as the current object for searching
//Returns false, if not successfull
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD enterObjectArray :BOOL

!__IMPLEMENTATION__!
IF ready AND treeLevel < levelsMax THEN
	CASE lastValueType OF
		EStructType.object,EStructType.tArray:
			treeLevel			:=		treeLevel + 1;
			treeSelectedTypes[treeLevel]	:=		lastValueType;
			treeSelected[treeLevel]			:=		lastValueStart;
			treeSelectedArrayProg[treeLevel]:=		0;
			lastValueStart		:=		0;
			lastValueType		:=		EStructType.none;
			lastKeyStart		:=		0;
			enterObjectArray	:=		TRUE;
	END_CASE
END_IF