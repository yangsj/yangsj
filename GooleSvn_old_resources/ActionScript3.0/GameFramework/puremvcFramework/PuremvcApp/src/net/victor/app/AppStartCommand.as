package net.victor.app
{
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import net.victor.code.app.AppMainMediator;
	import net.victor.code.framework.AppCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 *  
	 * notification: body Application
	 */	
	public class AppStartCommand extends AppCommand
	{
		override public function execute(notification:INotification):void
		{
			
			
			var mainMediator:AppMainMediator = new AppMainMediator(notification.body as Stage);
			this.facade.registerMediator(mainMediator);
			
		
			registerCommands();
			
			
			//启动管理中心
			this.facade.sendNotification(AppNotificationName.AppManagerCenterInitCommand);
		

		}
		
		private function registerCommands():void
		{
			this.facade.registerCommand(AppNotificationName.AppManagerCenterInitCommand, AppManagerCenterInitCommand);
			
		}
	}
}