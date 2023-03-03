{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Empties array, and releases memory
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-03-22 | Creation
METHOD empty
!__IMPLEMENTATION__!
S_lenght			:=		0;
S_blockSize			:=		0;
FU_SafeDelete(pMem:=S_array^);