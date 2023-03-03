//This method finds the next key/value pair in the current object
//Returns none, when there are no more keys
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD nextKey : EStructType

(*%!%__DELIMITER__%!%*)
nextKey		:=		reader.nextKey();