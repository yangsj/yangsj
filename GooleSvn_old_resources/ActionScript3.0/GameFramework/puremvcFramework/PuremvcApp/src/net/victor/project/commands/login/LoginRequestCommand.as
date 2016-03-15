package net.victor.project.commands.login
{
	import flash.display.Sprite;
	
	import net.victor.project.commands.base.WebServiceExchangeCommand;
	import net.victor.project.notificationNames.LoadResourcesNotificationNames;
	import net.victor.project.notificationNames.LoadingBarNotificationNames;
	import net.victor.project.protocol.wpvo.LoginProtocal;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class LoginRequestCommand extends WebServiceExchangeCommand
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		public function LoginRequestCommand()
		{
			super();
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
//			var tp:LoginProtocal=new LoginProtocal();
//			this.netWorkRouter.send(tp,this);
			
			this.facade.sendNotification(LoadingBarNotificationNames.ShowLoadingBardCommand);
			this.facade.sendNotification(LoadResourcesNotificationNames.LoadResourcesCommand);
		}
		
		override public function onComplete(result:Object):void
		{
			if (isSuccess(result) == false) return ;
			
			this.facade.sendNotification(LoadingBarNotificationNames.ShowLoadingBardCommand);
			
			this.facade.sendNotification(LoadResourcesNotificationNames.LoadResourcesCommand);
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}