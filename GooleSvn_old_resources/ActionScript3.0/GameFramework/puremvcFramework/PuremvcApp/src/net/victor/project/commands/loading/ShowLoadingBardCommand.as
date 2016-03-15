package net.victor.project.commands.loading
{
	
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.models.loading.LoadingBarDataVo;
	import net.victor.project.views.ViewMediatorNames;
	import net.victor.project.views.loading.LoadingBarMediator;
	import net.victor.code.app.ContainerLayer;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ShowLoadingBardCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function ShowLoadingBardCommand()
		{
			super();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			var loadingBarmediator:LoadingBarMediator = this.facade.retrieveMediator(ViewMediatorNames.LoadingBarMediator) as LoadingBarMediator;
			if(null == loadingBarmediator)
			{
				loadingBarmediator = new LoadingBarMediator(ViewMediatorNames.LoadingBarMediator);
				this.facade.registerMediator(loadingBarmediator);
			}
			
			this.panelManager.showPanel(ViewMediatorNames.LoadingBarMediator, ContainerLayer.TOP_LAYER);
		}
		
		
		
	}
}