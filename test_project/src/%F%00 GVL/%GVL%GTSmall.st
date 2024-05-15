{
  "exclude_from_build": false, 
  "link_always": false
}
!__DECLARATION__!
//This is the textlist file for the system, texts are added here and refered to in the code, this is read only
//This list contains texts starting with a small character
{attribute 'qualified_only'}
{attribute 'global_init_slot' := '1'}
VAR_GLOBAL
	S_empty						:POINTER TO STRING(0)	:=	ADR('');
	//A
	Saccept						:POINTER TO STRING(6)	:=	ADR('accept');
	Saccess						:POINTER TO STRING(6)	:=	ADR('access');
	SaccessLevel				:POINTER TO STRING(11)	:=	ADR('accessLevel');
	SaccessToken				:POINTER TO STRING(11)	:=	ADR('accessToken');
	Saction						:POINTER TO STRING(6)	:=	ADR('action');
	SaddAddress					:POINTER TO STRING(10)	:=	ADR('addAddress');
	SaddCard					:POINTER TO STRING(7)	:=	ADR('addCard');
	SaddClient					:POINTER TO STRING(9)	:=	ADR('addClient');
	SaddIp						:POINTER TO STRING(5)	:=	ADR('addIp');
	SaddNode					:POINTER TO STRING(7)	:=	ADR('addNode');
	Saddress					:POINTER TO STRING(7)	:=	ADR('address');
	Sadds						:POINTER TO STRING(4)	:=	ADR('adds');
	Sadmin						:POINTER TO STRING(5)	:=	ADR('admin');
	Samount						:POINTER TO STRING(6)	:=	ADR('amount');
	SamountCard					:POINTER TO STRING(10)	:=	ADR('amountCard');
	SamountInputs				:POINTER TO STRING(12)	:=	ADR('amountInputs');
	SarrSize					:POINTER TO STRING(7)	:=	ADR('arrSize');
	SalarmAlert					:POINTER TO STRING(10)	:=	ADR('alarmAlert');
	SalarmID					:POINTER TO STRING(7)	:=	ADR('alarmID');
	SaValue						:POINTER TO STRING(6)	:=	ADR('aValue');
	Saxis						:POINTER TO STRING(4)	:=	ADR('axis');
	//B
	Sbaudrate					:POINTER TO STRING(8)	:=	ADR('baudrate');
	SbuffSize					:POINTER TO STRING(8)	:=	ADR('buffSize');
	Sbutton						:POINTER TO STRING(6)	:=	ADR('button');
	Sbuzzer						:POINTER TO STRING(6)	:=	ADR('buzzer');
	SbuzzerUnit					:POINTER TO STRING(10)	:=	ADR('buzzerUnit');
	SbitSize					:POINTER TO STRING(7)	:=	ADR('bitSize');
	SbitOffset					:POINTER TO STRING(9)	:=	ADR('bitOffset');
	SblockPass					:POINTER TO STRING(9)	:=	ADR('blockPass');
	SbuzzOnTransfer				:POINTER TO STRING(14)	:=	ADR('buzzOnTransfer');
	SbuzzWithMaster				:POINTER TO STRING(14)	:=	ADR('buzzWithMaster');
	SbValue						:POINTER TO STRING(6)	:=	ADR('bValue');
	SbyteOffset					:POINTER TO STRING(10)	:=	ADR('byteOffset');
	//C
	ScanAck						:POINTER TO STRING(6)	:=	ADR('canAck');
	Scancel						:POINTER TO STRING(6)	:=	ADR('cancel');
	ScardID						:POINTER TO STRING(6)	:=	ADR('cardID');
	ScardNum					:POINTER TO STRING(7)	:=	ADR('cardNum');
	Scards						:POINTER TO STRING(5)	:=	ADR('cards');
	ScarouselPos				:POINTER TO STRING(11)	:=	ADR('carouselPos');
	Scd							:POINTER TO STRING(2)	:=	ADR('cd');
	Schanged					:POINTER TO STRING(7)	:=	ADR('changed');
	SclearDelay					:POINTER TO STRING(10)	:=	ADR('clearDelay');
	SclientID					:POINTER TO STRING(8)	:=	ADR('clientID');
	Sclients					:POINTER TO STRING(7)	:=	ADR('clients');
	Sclient						:POINTER TO STRING(6)	:=	ADR('client');
	Sclose						:POINTER TO STRING(5)	:=	ADR('close');
	ScloseV1					:POINTER TO STRING(7)	:=	ADR('closeV1');
	ScloseV2					:POINTER TO STRING(7)	:=	ADR('closeV2');
	ScloseV3					:POINTER TO STRING(7)	:=	ADR('closeV3');
	Scode						:POINTER TO STRING(4)	:=	ADR('code');
	Scoefficient				:POINTER TO STRING(11)	:=	ADR('coefficient');
	Scommand					:POINTER TO STRING(7)	:=	ADR('command');
	Scond						:POINTER TO STRING(4)	:=	ADR('cond');
	Scondition					:POINTER TO STRING(9)	:=	ADR('condition');
	Sconditions					:POINTER TO STRING(10)	:=	ADR('conditions');
	Sconnection					:POINTER TO STRING(10)	:=	ADR('connection');
	Scontrol					:POINTER TO STRING(7)	:=	ADR('control');
	ScontrolMode				:POINTER TO STRING(11)	:=	ADR('controlMode');
	SconvA						:POINTER TO STRING(5)	:=	ADR('convA');
	SconvB						:POINTER TO STRING(5)	:=	ADR('convB');
	Screation					:POINTER TO STRING(8)	:=	ADR('creation');
	ScurrentLicense				:POINTER TO STRING(14)	:=	ADR('currentLicense');
	Scylinders					:POINTER TO STRING(9)	:=	ADR('cylinders');
	ScylinderModules			:POINTER TO STRING(15)	:=	ADR('cylinderModules');
	//D
	Sdata						:POINTER TO STRING(4)	:=	ADR('data');
	SdataBits					:POINTER TO STRING(8)	:=	ADR('dataBits');
	SdeadZoneIn					:POINTER TO STRING(10)	:=	ADR('deadZoneIn');
	SdeadZoneOut				:POINTER TO STRING(11)	:=	ADR('deadZoneOut');
	SdeadZoneOutInstant			:POINTER TO STRING(18)	:=	ADR('deadZoneOutInstant');
	Sdecode						:POINTER TO STRING(6)	:=	ADR('decode');
	Sdefault					:POINTER TO STRING(7)	:=	ADR('default');
	SdefaultWatchGroup			:POINTER TO STRING(17)	:=	ADR('defaultWatchGroup');
	Sdelay						:POINTER TO STRING(5)	:=	ADR('delay');
	SdelayIn					:POINTER TO STRING(7)	:=	ADR('delayIn');
	SdelayOut					:POINTER TO STRING(8)	:=	ADR('delayOut');
	Sdeleted					:POINTER TO STRING(7)	:=	ADR('deleted');
	Sdes						:POINTER TO STRING(3)	:=	ADR('des');
	Sdesc						:POINTER TO STRING(4)	:=	ADR('desc');
	Sdestination				:POINTER TO STRING(3)	:=	ADR('destination');
	Sdifferences				:POINTER TO STRING(11)	:=	ADR('differences');
	SdifferencesAmount			:POINTER TO STRING(17)	:=	ADR('differencesAmount');
	//E
	Senabled					:POINTER TO STRING(7)	:=	ADR('enabled');
	Sexample					:POINTER TO STRING(7)	:=	ADR('example');
	//F
	Sfeedback					:POINTER TO STRING(8)	:=	ADR('feedback');
	Sframetype					:POINTER TO STRING(9)	:=	ADR('frametype');
	Sfrom						:POINTER TO STRING(4)	:=	ADR('from');
	SfuncCode					:POINTER TO STRING(8)	:=	ADR('funcCode');
	Sformat						:POINTER TO STRING(6)	:=	ADR('format');
	//G
	SgeneralBuzzer				:POINTER TO STRING(13)	:=	ADR('generalBuzzer');
	SgeneralOutput				:POINTER TO STRING(13)	:=	ADR('generalOutput');
	SglobalBuzzerTime			:POINTER TO STRING(16)	:=	ADR('globalBuzzerTime');
	SglobalSilence				:POINTER TO STRING(13)	:=	ADR('globalSilence');
	SglobalSilenceWhenWatch		:POINTER TO STRING(22)	:=	ADR('globalSilenceWhenWatch');
	Sgroup						:POINTER TO STRING(5)	:=	ADR('group');
	//H
	Shandshake					:POINTER TO STRING(9)	:=	ADR('handshake');
	//I
	Sid							:POINTER TO STRING(2)	:=	ADR('id');
	Sids						:POINTER TO STRING(3)	:=	ADR('ids');
	Sintake						:POINTER TO STRING(6)	:=	ADR('intake');
	Sinputs						:POINTER TO STRING(6)	:=	ADR('inputs');
	Sip							:POINTER TO STRING(2)	:=	ADR('ip');
	SipAddress					:POINTER TO STRING(9)	:=	ADR('ipAddress');
	SisClosed					:POINTER TO STRING(8)	:=	ADR('isClosed');
	SisClosedV1					:POINTER TO STRING(10)	:=	ADR('isClosedV1');
	SisClosedV2					:POINTER TO STRING(10)	:=	ADR('isClosedV2');
	SisClosedV3					:POINTER TO STRING(10)	:=	ADR('isClosedV3');
	SisMaster					:POINTER TO STRING(8)	:=	ADR('isMaster');
	SisOpen						:POINTER TO STRING(6)	:=	ADR('isOpen');
	SisOpenV1					:POINTER TO STRING(8)	:=	ADR('isOpenV1');
	SisOpenV2					:POINTER TO STRING(8)	:=	ADR('isOpenV2');
	SisOpenV3					:POINTER TO STRING(8)	:=	ADR('isOpenV3');
	//K
	SkeepState					:POINTER TO STRING(9)	:=	ADR('keepState');
	//L
	Sld							:POINTER TO STRING(2)	:=	ADR('ld');
	Slevel						:POINTER TO STRING(5)	:=	ADR('level');
	Slicense					:POINTER TO STRING(7)	:=	ADR('license');
	Slight						:POINTER TO STRING(5)	:=	ADR('light');
	Slist						:POINTER TO STRING(4)	:=	ADR('list');
	Slog						:POINTER TO STRING(3)	:=	ADR('log');
	SlogModules					:POINTER TO STRING(10)	:=	ADR('logModules');
	SlogType					:POINTER TO STRING(7)	:=	ADR('logType');
	SloadModule					:POINTER TO STRING(10)	:=	ADR('loadModule');
	SloadPercent				:POINTER TO STRING(11)	:=	ADR('loadPercent');
	SlowerDifference			:POINTER TO STRING(15)	:=	ADR('lowerDifference');
	Slp							:POINTER TO STRING(2)	:=	ADR('lp');
	//M
	Smacaddress					:POINTER TO STRING(10)	:=	ADR('macaddress');
	Smax						:POINTER TO STRING(3)	:=	ADR('max');
	SmaxAmount					:POINTER TO STRING(9)	:=	ADR('maxAmount');
	SmaxDeadzone				:POINTER TO STRING(11)	:=	ADR('maxDeadzone');
	SmaxInputs					:POINTER TO STRING(9)	:=	ADR('maxInputs');
	Smessage					:POINTER TO STRING(7)	:=	ADR('message');
	Smid						:POINTER TO STRING(3)	:=	ADR('mid');
	SmidDeadzone				:POINTER TO STRING(11)	:=	ADR('midDeadzone');
	Smin						:POINTER TO STRING(3)	:=	ADR('min');
	SminDeadzone				:POINTER TO STRING(11)	:=	ADR('minDeadzone');
	SmodbusUnit					:POINTER TO STRING(10)	:=	ADR('modbusUnit');
	Smode						:POINTER TO STRING(4)	:=	ADR('mode');
	Smodule						:POINTER TO STRING(6)	:=	ADR('module');
	SmodID						:POINTER TO STRING(5)	:=	ADR('modID');
	Smoduid						:POINTER TO STRING(6)	:=	ADR('moduid');
	Smoved						:POINTER TO STRING(5)	:=	ADR('moved');
	//N
	Sna							:POINTER TO STRING(3)	:=	ADR('n/a');
	Sname						:POINTER TO STRING(4)	:=	ADR('name');
	SneedUser					:POINTER TO STRING(8)	:=	ADR('needUser');
	Snew						:POINTER TO STRING(3)	:=	ADR('new');
	Snewest						:POINTER TO STRING(6)	:=	ADR('newest');
	SnewPass					:POINTER TO STRING(7)	:=	ADR('newPass');
	Snext						:POINTER TO STRING(4)	:=	ADR('next');
	SnextText					:POINTER TO STRING(8)	:=	ADR('nextText');
	Snt							:POINTER TO STRING(2)	:=	ADR('nt');
	Snum						:POINTER TO STRING(3)	:=	ADR('num');
	Snumber						:POINTER TO STRING(6)	:=	ADR('number');
	//O
	SoffTime					:POINTER TO STRING(7)	:=	ADR('offTime');
	SoffTimeFault				:POINTER TO STRING(12)	:=	ADR('offTimeFault');
	Sold						:POINTER TO STRING(3)	:=	ADR('old');
	SoldLicenses				:POINTER TO STRING(11)	:=	ADR('oldLicenses');
	SoldPass					:POINTER TO STRING(7)	:=	ADR('oldPass');
	SonTime						:POINTER TO STRING(6)	:=	ADR('onTime');
	SonWatch					:POINTER TO STRING(7)	:=	ADR('onWatch');
	Sopen						:POINTER TO STRING(4)	:=	ADR('open');
	SopenV1						:POINTER TO STRING(6)	:=	ADR('openV1');
	SopenV2						:POINTER TO STRING(6)	:=	ADR('openV2');
	SopenV3						:POINTER TO STRING(6)	:=	ADR('openV3');
	Sorder						:POINTER TO STRING(5)	:=	ADR('order');
	SorderMode					:POINTER TO STRING(9)	:=	ADR('orderMode');
	SorderSpeed					:POINTER TO STRING(10)	:=	ADR('orderSpeed');
	//P
	Sparams						:POINTER TO STRING(6)	:=	ADR('params');
	Sparent						:POINTER TO STRING(6)	:=	ADR('parent');
	Sparity						:POINTER TO STRING(6)	:=	ADR('parity');	
	SpassBlockListMode			:POINTER TO STRING(17)	:=	ADR('passBlockListMode');
	SpassBlockListType			:POINTER TO STRING(17)	:=	ADR('passBlockListType');
	SpassBlockListTypeText		:POINTER TO STRING(21)	:=	ADR('passBlockListTypeText');	
	Spasscodes					:POINTER TO STRING(9)	:=	ADR('passcodes');
	Spasscode					:POINTER TO STRING(8)	:=	ADR('passcode');
	Spassword					:POINTER TO STRING(8)	:=	ADR('password');
	Spath						:POINTER TO STRING(4)	:=	ADR('path');
	Spdo						:POINTER TO STRING(3)	:=	ADR('pdo');
	SpdoTX						:POINTER TO STRING(5)	:=	ADR('pdoTX');
	SpdoRX						:POINTER TO STRING(5)	:=	ADR('pdoRX');
	SpendingID					:POINTER TO STRING(9)	:=	ADR('pendingID');
	Sphysical					:POINTER TO STRING(8)	:=	ADR('physical');
	Spid						:POINTER TO STRING(3)	:=	ADR('pid');
	Sping						:POINTER TO STRING(4)	:=	ADR('ping');
	Sport						:POINTER TO STRING(4)	:=	ADR('port');
	//R
	Srateuid					:POINTER TO STRING(7)	:=	ADR('rateuid');
	SreadWrite					:POINTER TO STRING(9)	:=	ADR('readWrite');
	Sreason						:POINTER TO STRING(6)	:=	ADR('reason');
	Srem						:POINTER TO STRING(3)	:=	ADR('rem');
	SremoveClient				:POINTER TO STRING(12) 	:=	ADR('removeClient');
	Sremoves					:POINTER TO STRING(7) 	:=	ADR('removes');
	Sreset						:POINTER TO STRING(5) 	:=	ADR('reset');
	Sresult						:POINTER TO STRING(6) 	:=	ADR('result');
	Sreturn						:POINTER TO STRING(6)	:=	ADR('return');
	SreTrigDelay				:POINTER TO STRING(11)	:=	ADR('reTrigDelay');
	Sreverse					:POINTER TO STRING(7)	:=	ADR('reverse');
	Srevoke						:POINTER TO STRING(6)	:=	ADR('revoke');
	Srunning					:POINTER TO STRING(7)	:=	ADR('running');
	SrW							:POINTER TO STRING(2)	:=	ADR('rW');
	//S
	Ssamples					:POINTER TO STRING(7)	:=	ADR('samples');
	Sscale						:POINTER TO STRING(5)	:=	ADR('scale');
	Sscan						:POINTER TO STRING(4)	:=	ADR('scan');
	SscanName					:POINTER TO STRING(8)	:=	ADR('scanName');
	SscanResult					:POINTER TO STRING(10)	:=	ADR('scanResult');
	SsecsLeft					:POINTER TO STRING(8)	:=	ADR('secsLeft');
	Sself						:POINTER TO STRING(4)	:=	ADR('self');
	Sset						:POINTER TO STRING(3) 	:=	ADR('set');
	Ssid						:POINTER TO STRING(3)	:=	ADR('sid');
	Ssigned						:POINTER TO STRING(6)	:=	ADR('signed');
	Ssize						:POINTER TO STRING(4)	:=	ADR('size');
	Sslow						:POINTER TO STRING(4) 	:=	ADR('slow');
	Sspeed						:POINTER TO STRING(5)	:=	ADR('speed');
	SspeedFeedback				:POINTER TO STRING(13)	:=	ADR('speedFeedback');
	SspeedOrder					:POINTER TO STRING(10)	:=	ADR('speedOrder');
	Sstart						:POINTER TO STRING(5) 	:=	ADR('start');
	SstartByte					:POINTER TO STRING(9) 	:=	ADR('startByte');
	SstartMode					:POINTER TO STRING(9) 	:=	ADR('startMode');
	Sstate						:POINTER TO STRING(5)	:=	ADR('state');
	Sstatus						:POINTER TO STRING(6)	:=	ADR('status');
	Sstep						:POINTER TO STRING(4)	:=	ADR('step');
	Sstop						:POINTER TO STRING(4)	:=	ADR('stop');
	SstopBit					:POINTER TO STRING(7)	:=	ADR('stopBit');
	SstopMode					:POINTER TO STRING(8)	:=	ADR('stopMode');
	SsubID						:POINTER TO STRING(5)	:=	ADR('subID');
	Ssuccess					:POINTER TO STRING(7) 	:=	ADR('success');
	Ssystem						:POINTER TO STRING(6)	:=	ADR('system');
	SsystemList					:POINTER TO STRING(10)	:=	ADR('systemList');
	//T
	Stempuid					:POINTER TO STRING(7)	:=	ADR('tempuid');
	Stest						:POINTER TO STRING(4)	:=	ADR('test');
	Stext						:POINTER TO STRING(4) 	:=	ADR('text');
	Stime						:POINTER TO STRING(4) 	:=	ADR('time');
	StimeOut					:POINTER TO STRING(7) 	:=	ADR('timeOut');
	Sto							:POINTER TO STRING(2)	:=	ADR('to');
	StoID						:POINTER TO STRING(4)	:=	ADR('toID');
	Stotal						:POINTER TO STRING(5)	:=	ADR('total');
	StrigDelay					:POINTER TO STRING(9)	:=	ADR('trigDelay');
	StwoWay						:POINTER TO STRING(6)	:=	ADR('twoWay');
	Stype						:POINTER TO STRING(4)	:=	ADR('type');
	StypeText					:POINTER TO STRING(8)	:=	ADR('typeText');
	//U
	Sud							:POINTER TO STRING(2)	:=	ADR('ud');
	Suid						:POINTER TO STRING(3)	:=	ADR('uid');
	Sunlimited					:POINTER TO STRING(9)	:=	ADR('unlimited');
	Sunit						:POINTER TO STRING(4)	:=	ADR('unit');
	Sunits						:POINTER TO STRING(5)	:=	ADR('units');
	Supdate						:POINTER TO STRING(6)	:=	ADR('update');
	SupdateRate					:POINTER TO STRING(10)	:=	ADR('updateRate');
	SupperDifference			:POINTER TO STRING(15)	:=	ADR('upperDifference');
	SuseAverage					:POINTER TO STRING(10)	:=	ADR('useAverage');
	Suser						:POINTER TO STRING(4)	:=	ADR('user');
	Suser2						:POINTER TO STRING(5)	:=	ADR('user2');
	Susername					:POINTER TO STRING(8)	:=	ADR('username');
	Susers						:POINTER TO STRING(5)	:=	ADR('users');
	Sut							:POINTER TO STRING(2)	:=	ADR('ut');
	//V
	Sva							:POINTER TO STRING(2)	:=	ADR('va');
	Svalue						:POINTER TO STRING(5)	:=	ADR('value');
	Sval						:POINTER TO STRING(3)	:=	ADR('val');
	SvalID						:POINTER TO STRING(5)	:=	ADR('valID');
	Sversion					:POINTER TO STRING(7)	:=	ADR('version');
	Svf							:POINTER TO STRING(2)	:=	ADR('vf');
	Svt							:POINTER TO STRING(2)	:=	ADR('vt');
	SvariableAccess				:POINTER TO STRING(14)	:=	ADR('variableAccess');
	//W
	Swait						:POINTER TO STRING(4)	:=	ADR('wait');
	SwatchAckTime				:POINTER TO STRING(9)	:=	ADR('watchAckTime');
	SwatchID					:POINTER TO STRING(7)	:=	ADR('watchID');
	SwatchSystemEnabled			:POINTER TO STRING(18)	:=	ADR('watchSystemEnabled');
	SwatchSystem				:POINTER TO STRING(11)	:=	ADR('watchSystem');
	SwatchTimeOut				:POINTER TO STRING(12) 	:=	ADR('watchTimeOut');
	SxAxis						:POINTER TO STRING(5)	:=	ADR('xAxis');	
	Sx1Address					:POINTER TO STRING(9)	:=	ADR('x1Address');	
	Sx2Address					:POINTER TO STRING(9)	:=	ADR('x2Address');
	//Y
	SyAxis						:POINTER TO STRING(5)	:=	ADR('yAxis');
	
	//Numbers
	Szero						:POINTER TO STRING(1)	:=	ADR('0');		
	Sone						:POINTER TO STRING(1)	:=	ADR('1');		
	Stwo						:POINTER TO STRING(1)	:=	ADR('2');		
	Sthree						:POINTER TO STRING(1)	:=	ADR('3');		
	Sfour						:POINTER TO STRING(1)	:=	ADR('4');		
	Sfive						:POINTER TO STRING(1)	:=	ADR('5');		
	Ssix						:POINTER TO STRING(1)	:=	ADR('6');		
	Sseven						:POINTER TO STRING(1)	:=	ADR('7');		
	Seight						:POINTER TO STRING(1)	:=	ADR('8');		
	Snine						:POINTER TO STRING(1)	:=	ADR('9');		
	Sten						:POINTER TO STRING(2)	:=	ADR('10');
END_VAR