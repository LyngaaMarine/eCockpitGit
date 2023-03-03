{attribute 'qualified_only'}
VAR_GLOBAL
	modMan							:FB_ModuleManager;
//#####		Designator List
	DesModule						:AModuleDes:='MODUL';
	DesModuleManager				:AModuleDes:='MODMA';
	
	DesGroup						:AModuleDes:='GROUP';
	
	//Alarms
	DesAlarmLogger					:AModuleDes:='ASLOG';
	DesAlarm						:AModuleDes:='ASALA';
	DesAlarmList					:AModuleDes:='ASALL';
	DesAlarmRegistry				:AModuleDes:='ASREG';
	DesAlarmWatchGroup				:AModuleDes:='ASWUN';
	DesAlarmBuzzerUnit				:AModuleDes:='ASBUN';

	//The PLC
	DesPLC							:AModuleDes:='PLCIF';
	DesLicenseSystem				:AModuleDes:='LICES';

	//Server Designators
	DesAccessManager				:AModuleDes:='ACMAN';
	DesDataServer					:AModuleDes:='DTSRV';
	DesDataServerClient				:AModuleDes:='DTSRC';
	DesDataServerClientFixed		:AModuleDes:='DTSCF';
	
	//User Management
	DesUser							:AModuleDes:='USERU';
	DesUserGroup					:AModuleDes:='USRGP';
	DesUserManager					:AModuleDes:='USRMG';
	
	//Modules
	DesModules						:AModuleDes:='MODUS';
	DesDriver						:AModuleDes:='DRIVE';
	DesJunction						:AModuleDes:='JUNCT';

	DesFuelConsumption				:AModuleDes:='FUCON';
	DesFuelTotal					:AModuleDes:='FUTOT';
	DesEngineTempMaxDeviation		:AModuleDes:='ETMDV';
	DesHourCounterMan				:AModuleDes:='HCMAN';
	DesHourCounter					:AModuleDes:='HCOUN';	
	
	//IO System
	DesIOSystem						:AModuleDes:='IOSYS';
	
	DesSerialBase					:AModuleDes:='SERBA';
	
	//Generic IO
	DesIOGenericLive				:AModuleDes:='IOGEL';
	DesIOGenericBuff				:AModuleDes:='IOGEB';

	DesIOGenericAnalogRead			:AModuleDes:='IOGAI';
	DesIOGenericDigitalRead			:AModuleDes:='IOGDI';

	//Value
	DesValueBase					:AModuleDes:='VABAS';
	DesBitAccess					:AModuleDes:='BITAC';
	DesLinearConverter				:AModuleDes:='LICON';
	DesTableConverter				:AModuleDes:='TABCO';
	DesMover						:AModuleDes:='MOVER';
	DesFilterManager				:AModuleDes:='FILMA';
	DesFilter						:AModuleDes:='FILTE';
	
	//User Values
	DesUserValueRegistry			:AModuleDes:='USVRE';
	DesUserValue					:AModuleDes:='USVAL';

	//Modbus
	DesModbusIO						:AModuleDes:='MBIOV';
	DesModbusTCP					:AModuleDes:='MBTCP';
	DesModbusSerial					:AModuleDes:='MBSER';

	//CanOpen
	DesCanOpenNode					:AModuleDes:='CONOD';
	DesCanOpenPDO					:AModuleDes:='COPDO';

	//Wago Specifics
	DesWago							:AModuleDes:='WGOWA';

	//PLC
	DesWagoPLCSerialPort			:AModuleDes:='WGPSP';
	
	//Wago Generic IO
	DesWagoIOGenericBase			:AModuleDes:='WIBAS';
	DesWagoIOGenericAnalogInput		:AModuleDes:='WIANA';
	DesWagoIOGenericDigitalInput	:AModuleDes:='WIDIG';
	DesWagoIOGenericRawInput		:AModuleDes:='WIRAW';
	
	//Local
	DesWagoLocal					:AModuleDes:='WLOCA';
	//Local Cards
	DesWagoCardBase					:AModuleDes:='WCARD';
	DesWagoCardGenericBase			:AModuleDes:='WGBAS';
	DesWagoCardGenericDigitalInput	:AModuleDes:='WGDIN';
	DesWagoCardGenericDigitalOutput	:AModuleDes:='WGDOU';
	DesWagoCardGenericDigitalInOut	:AModuleDes:='WGDIO';
	
	DesWagoCardGenericAnalogInput	:AModuleDes:='WGAIN';
	DesWagoCardGenericAnalogOutput	:AModuleDes:='WGAOU';
	DesWagoCardGenericAnalogInOut	:AModuleDes:='WGAIO';
	
	DesWagoCard404					:AModuleDes:='WC404';
	DesWagoCard450					:AModuleDes:='WC450';
	DesWagoCard451					:AModuleDes:='WC451';
	DesWagoCard458					:AModuleDes:='WC458';
	DesWagoCard471					:AModuleDes:='WC471';
	DesWagoCard496					:AModuleDes:='WC496';
	DesWagoCard497					:AModuleDes:='WC497';
	DesWagoCard563					:AModuleDes:='WC563';
	DesWagoCard626					:AModuleDes:='WC626';
	DesWagoCard634					:AModuleDes:='WC634';
	DesWagoCard652					:AModuleDes:='WC652';
	DesWagoCard658					:AModuleDes:='WC658';
	DesWagoCard658TransBase			:AModuleDes:='W658T';
	DesWagoCard658Mapped			:AModuleDes:='W658M';
	DesWagoCard658MappedInput		:AModuleDes:='W658I';
	DesWagoCard658MappedOutput		:AModuleDes:='W658O';
	DesWagoCard658CanOpen			:AModuleDes:='W658C';

	//Specifics
	DesWago8217SMS					:AModuleDes:='W8217';
	
	//Control System
	DesControlSystem				:AModuleDes:='CTSYS';
	DesControlCommands				:AModuleDes:='CTCOS';
	DesControlCommand				:AModuleDes:='CTCOM';
	DesControlInputs				:AModuleDes:='CTINS';
	DesControlInputBase				:AModuleDes:='CTIBA';
	DesControlInputAnalog			:AModuleDes:='CTIAN';
	DesControlOutputs				:AModuleDes:='CTOUS';
	DesControlOutputBase			:AModuleDes:='CTOBA';
	DesControlOutputAnalog			:AModuleDes:='CTOAN';
END_VAR