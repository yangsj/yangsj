package net.victor.project.commands.net
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.protocol.amf.msg.KeepAlive22;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class KeepAliveResponseCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		override public function execute(notification:INotification):void
		{
			trace("this is keepAlive");
			var aaa:*=notification.body;
			var msg:KeepAlive22 = notification.body as KeepAlive22;
			if(msg)
			{
				trace(msg.serverTime);
			}
			trace("keep alive");
		}
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}