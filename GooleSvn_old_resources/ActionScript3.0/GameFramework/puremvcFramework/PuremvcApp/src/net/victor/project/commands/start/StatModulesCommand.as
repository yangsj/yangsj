package net.victor.project.commands.start
{
	import flash.utils.setTimeout;
	
	import net.victor.project.commands.homepage.StartHomePageCommand;
	import net.victor.project.commands.loading.StartLoadingBarAboutCommand;
	import net.victor.project.models.ModelProxyNames;
	import net.victor.project.models.user.UserModelProxy;
	import net.victor.project.notificationNames.HomePageNotificationNames;
	import net.victor.project.notificationNames.LoadingBarNotificationNames;
	import net.victor.project.notificationNames.LoginNotificationNames;
	import net.victor.code.framework.AppCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class StatModulesCommand extends AppCommand
	{
		override public function execute(notification:INotification):void
		{
			initProxies();
			
			addCommands();
			execCommands();
		}
		
		/**
		 * 添加数据代理 
		 * 
		 */		
		private function initProxies():void
		{
			
		}
		
		private function addCommands():void
		{
			this.facade.registerCommand(HomePageNotificationNames.StartHomePageCommand, StartHomePageCommand);
			
			
		}
		
		private function execCommands():void
		{
			//
			this.facade.sendNotification(HomePageNotificationNames.StartHomePageCommand);
			
		}
	}
}