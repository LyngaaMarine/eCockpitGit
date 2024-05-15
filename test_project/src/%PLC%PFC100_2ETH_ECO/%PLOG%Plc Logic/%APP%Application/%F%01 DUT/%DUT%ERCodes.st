{
  "external": false, 
  "exclude_from_build": false
}
!__DECLARATION__!
{attribute 'qualified_only'}
TYPE ERCodes :
(
	None			:=		0,
	OK				:=		1,
	MoreTime		:=		2,
	Finished		:=		3,
	offset			:=		100,
	//Server Generic
	CommandResponseSendData,

	//Programs
		//Shared Tasks
			NetworkIO,
			NetworkIO_deregisterNetworkModule,
			NetworkIO_registerNetworkModule,
		
	//Modules
		//Alarm System
			//Alarm Registry
				FB_AlarmRegistry_processAlarm,
				FB_AlarmRegistry_performWatchGlobalBuzzer,
				FB_AlarmRegistry_performGlobalSilence,
				FB_AlarmRegistry_performGlobalBuzzer,
				FB_AlarmRegistry_SYS_register,
				FB_AlarmRegistry_SYS_cycle,
				FB_AlarmRegistry_SYS_registerEventListener,
			//Alarm List
				FB_AlarmList_addClient,
				FB_AlarmList_checkClientList,
				FB_AlarmList_SYS_cleanUp,
				FB_AlarmList_SYS_loadData,
				FB_AlarmList_SYS_saveData,
				FB_AlarmList_SYS_changeConfig,
				FB_AlarmList_SYS_exportConfig,
				FB_AlarmList_SYS_packModule,
			//Alarm Watch Group
				FB_AlarmWatchGroup_performBuzzer,
				FB_AlarmWatchGroup_checkClientList,
				FB_AlarmWatchGroup_SYS_register,
				FB_AlarmWatchGroup_SYS_cleanUp,
				FB_AlarmWatchGroup_sendCommandToClients,
				FB_AlarmWatchGroup_performSilence,
				FB_AlarmWatchGroup_SYS_packModule,
				FB_AlarmWatchGroup_SYS_changeConfig,
				FB_AlarmWatchGroup_SYS_exportConfig,
				FB_AlarmWatchGroup_SYS_saveData,
				FB_AlarmWatchGroup_SYS_loadData,
		
		//IO System
			FB_IOSystem_SYS_register,
			FB_IOSystem_SYS_loadData,
			FB_IOSystem_SYS_saveData,
			FB_IOSystem_SYS_changeConfig,
			FB_IOSystem_SYS_exportConfig,
			FB_IOSystem_addModule,
			FB_IOSystem_removeModule,
			FB_IOSystem_registerMover,
			FB_IOSystem_deregisterMover,
			FB_IOSystem_registerFilter,
			FB_IOSystem_deregisterFilter,
			FB_IOSystem_SYS_cycle,
			FB_IOSystem_SYS_cleanUp,
			//Additions
				FB_TableConverter_setSize,
				FB_Filter_setAmountSamples,
			//Can Open
				FB_CanOpenNode_registerPDO,
				FB_CanOpenNode_deregisterPDO,

			//Condition
				Condition_importCondition,
				Condition_setSize,
			//Generic
				GenericIORaw_preCreation,
				GenericIOFloat_preCreation,
				GenericIODigital_preCreation,
			//Modbus
				//Modbus IO
					FB_ModbusIO_SYS_changeConfig,
				//Modbus TCP
					FB_ModbusTCP_SYS_register,
				//Modbus Serial
					FB_ModbusSerial_SYS_register,
	
		//Control System
		ControlInputs_register,
		ControlInputs_addSubInput,
		ControlInputAnalog_setInputAmount,
		ControlOutputs_register,
			
		//Modules
			FB_Modules_registerCycle,
			FB_Modules_run250msCycles,
			FB_Modules_run1000msCycles,
			FB_Modules_run5000msCycles,
			//Hour Counter
				FB_HourCounterManager_SYS_register,
				FB_HourCounterManager_SYS_cycle,
			//Functionality Modules
				EngineTempMaxDeviation_setCylinderAmount,
				EngineTempMaxDeviation_setDifferenceAmount,
				FilterManager_register,
				HourCounterManager_onChild,

		//System
			//Data Server
				//Data Server
					FB_DataServer_SYS_register,
					FB_DataServer_addCommandController,
					FB_DataServer_addDataInitializer,
					FB_DataServer_SYS_init,
					FB_DataServerClient_SYS_init,
					FB_DataServerClient_fixedClientsCycle,
					FB_DataServerClient_newMessage,
					FB_DataServerClient_globalSendCommand,
				//Data Server Client
					FB_DataServerClient_instrumentValueGet,
					FB_DataServerClient_instrumentValueSet,
				//Data Server Client Fixed
			//License System
				LicenseSystem_newSystemLicense,
			//Module Manager
				FB_ModuleManager_registerAutoLoadedModule,
				ModuleManager_addModuleShared,
				ModuleManager_allocateID,
				ModuleManager_setModuleByUID,
				ModuleManager_reorderChildren,
				ModuleManager_moveModuleFile,
				ModuleManager_registerChildWithModule,
				ModuleManager_queryManagementEvent,
				ModuleManager_processMangementEvent,
			//PLC
				FB_PLC_SYS_cycle,
				FB_PLC_SYS_registerEventListener,
			//User Management
				UserManagement_SYS_register,
				FB_UserManagement_changeAccessOfModule,
				FB_User_SYS_changeConfig,

			
		//Wago
			WagoLocalCardBase_creation,
			//IO
				WagoIOAnalog_preCreation,
				WagoIORaw_preCreation,
				WagoIODigital_preCreation,
			//750-652
				WagoLocalCard652_addSub,
			//750-658
				//Mapped
					FB_WagoLocalCard658Mapped_SYS_register,
					FB_WagoLocalCard658Mapped_SYS_cycle,
				//CanOpen
					FB_WagoLocalCard658CanOpen_SYS_register,
					FB_WagoLocalCard658CanOpen_SYS_cycle,
	
	//Function Blocks
	FB_JSONReader_initialize,
	FB_JSONWriter_initialize,
	FB_XMLReader_initialize,
	FB_XMLWriter_initialize,

	FB_LoadSave_LSStart,
	
	FB_Condition_moveSubCondition,
	
	FB_DynamicArray_allocateInternal,
	FB_DynamicArray_addElement,
	FB_DynamicArray_removeElementByIndex,
		
	FB_diSampleFilter_setAmountSamples,
	
	FB_TCPController_initialize,
	FB_TCPMultiPlexer_initialize,
	
	//Functions
	DynPointArrayIncSize,
	DynPointArrayOrderAdd,
	FU_DynIDArrayOrderAdd,
	FU_DynIDArrayIncSize,
	changeFileFolderAccess,
	FU_SetDynamicString,
	FU_WagoCardsToStruct,
	FU_copyFileByName,
	FU_deleteFileByName,
	FU_deleteDirByName,
	FU_copyDirByName,
	FU_renameFileByName,
	FU_renameDirByName,
	
	last
) WORD;
END_TYPE
