package net.victor.project.commands.homepage
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.notificationNames.HomePageNotificationNames;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-11-14 下午04:48:13
	 */
	public class StartHomePageCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function StartHomePageCommand()
		{
			super();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			this.facade.registerCommand(HomePageNotificationNames.CloseHomePageCommand, CloseHomePageCommand);
			
			this.facade.registerCommand(HomePageNotificationNames.ShowHomePageCommand, ShowHomePageCommand);
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}