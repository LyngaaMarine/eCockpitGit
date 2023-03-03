{"external": false, "exclude_from_build": false}
//Action parameters
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-08-21 | Creation
//The action parameters are stored as an array of dints, any single value must be the size of a dint, but a value is allowed to span multiple dints
//Eg. two bytes would still be [0] and [1]
//But a string(14) would only take up 4 dints (15 bytes)
TYPE AActionParams : ARRAY[0..99] OF UActionParamTypes; END_TYPE