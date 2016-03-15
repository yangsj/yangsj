package net.victor.project.commands.loading
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.views.ViewMediatorNames;
	import net.victor.project.views.loading.PreloaderBarMediator;
	import net.victor.code.app.ContainerLayer;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-19 下午01:24:20
	 */
	public class ShowPreloaderBarCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function ShowPreloaderBarCommand()
		{
			super();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			var preloaderBar:PreloaderBarMediator = this.facade.retrieveMediator(ViewMediatorNames.PreloaderBarMediator) as PreloaderBarMediator;
			if(null == preloaderBar)
			{
				preloaderBar = new PreloaderBarMediator(ViewMediatorNames.PreloaderBarMediator);
				this.facade.registerMediator(preloaderBar);
			}
			
			this.panelManager.showPanel(ViewMediatorNames.PreloaderBarMediator, ContainerLayer.TOP_LAYER);
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}