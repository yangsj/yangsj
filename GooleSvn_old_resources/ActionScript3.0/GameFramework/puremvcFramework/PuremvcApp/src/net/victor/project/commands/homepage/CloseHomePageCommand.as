package net.victor.project.commands.homepage
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.views.ViewMediatorNames;
	import net.victor.project.views.homepage.HomePageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	/** 
	 * 说明：
	 * @author 杨胜金
	 * 2011-11-14 下午04:20:24
	 */
	public class CloseHomePageCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function CloseHomePageCommand()
		{
			super();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			var homePage:HomePageMediator = facade.retrieveMediator(ViewMediatorNames.HomePageMediator) as HomePageMediator;
			
			homePage.clears();
			
			this.panelManager.hidePanel(ViewMediatorNames.HomePageMediator);
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}