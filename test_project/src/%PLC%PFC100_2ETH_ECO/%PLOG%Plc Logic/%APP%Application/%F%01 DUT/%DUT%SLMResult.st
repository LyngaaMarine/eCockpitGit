{
  "external": false, 
  "exclude_from_build": false
}
!__DECLARATION__!
//This struct contains a standard result code and text
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-11-20 | Creation
TYPE SLMResult :
STRUCT
	success			:BOOL := TRUE;	//Set true when successfull
	code			:WORD := ERCodes.OK;			//Individual result id, check database
	reason			:POINTER TO STRING(1000) := GTSmall.Sna;
	//Text can be set to constant text by using text := ADR('Constant Text')
END_STRUCT
END_TYPE
