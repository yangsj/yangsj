package net.victor.project.commands.net
{
	
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.notificationNames.LoginNotificationNames;
	import net.victor.project.notificationNames.ProtocolResponseNotificationNames;
	import net.victor.project.protocol.ProtocolResponseDictCreater;
	import net.victor.project.protocol.amf.ProtocolRegisterAlias;
	import net.victor.project.protocol.amf.msg.KeepAlive;
	import net.victor.project.protocol.amf.msg.TestProtocol;
	import net.victor.code.network.AMFConnectProperty;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class StartNetworkCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function StartNetworkCommand()
		{
			super();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
		//	ProtocolRegisterAlias.registerAlias();
			var amfConProper:AMFConnectProperty = new AMFConnectProperty(this.confProxy.amfGateway);
			this.netWorkRouter.addConnection(amfConProper);
			
			
		//	this.netWorkRouter.initProtocolDict(ProtocolResponseDictCreater.create());
			
	//		this.facade.registerCommand(ProtocolResponseNotificationNames.KeepAliveResponseCommand, KeepAliveResponseCommand);
			
			//this.netWorkRouter.send(new TestProtocol());
			//netWorkRouter.send(new KeepAlive());
//			this.facade.sendNotification(TestNotificationNames.TestRequestCommand);
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}