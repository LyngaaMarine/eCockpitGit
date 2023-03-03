//NON-Blocking method, is not threadsafe without calling getExclusive access before use
//Empties array, and releases memory
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD empty
(*%!%__DELIMITER__%!%*)
S_lenght			:=		0;
S_blockSize			:=		0;
FU_SafeDelete(pMem:=S_array);