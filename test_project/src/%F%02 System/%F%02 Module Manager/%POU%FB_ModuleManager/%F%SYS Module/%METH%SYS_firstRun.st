{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method called during boot process, after linking has finished
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-01-21 | Creation
METHOD SYS_firstRun
!__IMPLEMENTATION__!
///S_systemModbusListeners[0].Start(sIPAddress:=GPLC.plc.x1Address,uiPort:=10000);
///S_systemModbusListeners[0].Listen();