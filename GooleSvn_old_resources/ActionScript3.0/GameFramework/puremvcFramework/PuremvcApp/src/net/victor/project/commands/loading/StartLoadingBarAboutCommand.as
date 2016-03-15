package net.victor.project.commands.loading
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.notificationNames.LoadingBarNotificationNames;
	import net.victor.code.managers.NetworkProgressNotificationNames;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class StartLoadingBarAboutCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function StartLoadingBarAboutCommand()
		{
			super();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			this.facade.registerCommand(LoadingBarNotificationNames.ShowLoadingBardCommand, ShowLoadingBardCommand);
			
			this.facade.registerCommand(LoadingBarNotificationNames.CloseLoadingBarCommand, CloseLoadingBarCommand);
			
			this.facade.registerCommand(LoadingBarNotificationNames.LoadingBarProgressCommand, LoadingBarProgressCommand);
			
			
			this.facade.registerCommand(LoadingBarNotificationNames.ShowPreloaderBarCommand, ShowPreloaderBarCommand);
			
			this.facade.registerCommand(LoadingBarNotificationNames.ClosePreloaderBarCommand, ClosePreloaderBarCommand);
			
			this.facade.registerCommand(LoadingBarNotificationNames.PreloaderBarProgressCommand, PreloaderBarProgressCommand);
			
			
			this.facade.registerCommand(NetworkProgressNotificationNames.ShowNetworkLoadingBarCommand, ShowNetworkLoaingBarCommand);
			
			this.facade.registerCommand(NetworkProgressNotificationNames.CloseNetworkLoadingBarCommand, CloseNetworkLoaingBarCommand);
			
			
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}