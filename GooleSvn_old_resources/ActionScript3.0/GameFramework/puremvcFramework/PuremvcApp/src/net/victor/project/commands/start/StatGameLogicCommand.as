package net.victor.project.commands.start
{
	import flash.system.LoaderContext;
	
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.commands.loading.StartLoadingBarAboutCommand;
	import net.victor.project.commands.login.LoginRequestCommand;
	import net.victor.project.commands.net.StartNetworkCommand;
	import net.victor.project.commands.res.LoadResourcesCommand;
	import net.victor.project.commands.res.ResourceNameType;
	import net.victor.project.models.ModelProxyNames;
	import net.victor.project.models.conf.ConfigureModelProxy;
	import net.victor.project.models.conf.ConfigurePathType;
	import net.victor.project.notificationNames.LoadResourcesNotificationNames;
	import net.victor.project.notificationNames.LoadingBarNotificationNames;
	import net.victor.project.notificationNames.LoginNotificationNames;
	import net.victor.project.notificationNames.NetworkNotificationNames;
	import net.victor.project.notificationNames.StartGameNotificationNames;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	public class StatGameLogicCommand extends AppLogicCommandBase
	{
		override public function execute(notification:INotification):void
		{
			var configProxy:ConfigureModelProxy = new ConfigureModelProxy(ModelProxyNames.ConfigureModelProxy);
			this.facade.registerProxy(configProxy);
			
			//最先运行
			addCommands();
			startCommands();
		}
		
		
		private function startCommands():void
		{
			//启动功能
			this.facade.sendNotification(StartGameNotificationNames.StatModulesCommand);
			
			this.facade.sendNotification(NetworkNotificationNames.StartNetworkCommand);
			
			this.facade.sendNotification(LoginNotificationNames.LoginRequestCommand);
		}
		
		private function addCommands():void
		{
			this.facade.registerCommand(LoadingBarNotificationNames.StartLoadingBarAboutCommand, StartLoadingBarAboutCommand);
			
			this.facade.registerCommand(NetworkNotificationNames.StartNetworkCommand, StartNetworkCommand);
			
			this.facade.registerCommand(LoadResourcesNotificationNames.LoadResourcesCommand, LoadResourcesCommand);
			
			this.facade.registerCommand(StartGameNotificationNames.StatModulesCommand, StatModulesCommand);
			
			this.facade.registerCommand(LoginNotificationNames.LoginRequestCommand,LoginRequestCommand);
		}
	}
}