{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method makes the module return it's status variables
//[upTime=how long the system has been running,cpuLoad= load of cpu,sdCard=wether the sd card is in or out,memory=how much memory is left,x1Tx=x1 send data load in percent scaled up by 1000,x1Rx= x1 recieve data load in percent scaled up by 1000,x2Tx=x2 send data load in percent scaled up by 1000,x2Rx= x2 recieve data load in percent scaled up by 1000]
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 28-11-20 | Creation
METHOD SYS_status : SLMResult
VAR_INPUT
	client		:POINTER TO FB_DataServerClient;
	writer		:ITF_StructWriterBase;
END_VAR
!__IMPLEMENTATION__!
writer.writeDword(value:=S_upTime);