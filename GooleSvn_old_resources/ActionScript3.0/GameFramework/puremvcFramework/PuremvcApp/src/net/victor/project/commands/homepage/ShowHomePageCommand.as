package net.victor.project.commands.homepage
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.views.ViewMediatorNames;
	import net.victor.project.views.homepage.HomePageMediator;
	import net.victor.code.app.ContainerLayer;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	/** 
	 * 说明：
	 * @author 杨胜金
	 * 2011-11-14 下午04:19:54
	 */
	public class ShowHomePageCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function ShowHomePageCommand()
		{
			super();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			var homePage:HomePageMediator = facade.retrieveMediator(ViewMediatorNames.HomePageMediator) as HomePageMediator;
			if(!facade.retrieveMediator(ViewMediatorNames.HomePageMediator))
			{
				homePage = new HomePageMediator(ViewMediatorNames.HomePageMediator);
				facade.registerMediator(homePage);
			}
			homePage.setInitData(notification.body);
			if(this.panelManager.isPanelShow(ViewMediatorNames.HomePageMediator))
			{
				return;
			}
			
			this.panelManager.showPanel(ViewMediatorNames.HomePageMediator, ContainerLayer.SCENE_LAYER);
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}