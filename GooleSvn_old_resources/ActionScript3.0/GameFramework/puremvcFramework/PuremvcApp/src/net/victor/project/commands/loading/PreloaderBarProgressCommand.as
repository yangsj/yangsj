package net.victor.project.commands.loading
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.models.loading.LoadingBarDataVo;
	import net.victor.project.views.ViewMediatorNames;
	import net.victor.project.views.loading.PreloaderBarMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-19 下午01:31:42
	 */
	public class PreloaderBarProgressCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function PreloaderBarProgressCommand()
		{
			super();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			var loadingDataVo:LoadingBarDataVo = notification.body as LoadingBarDataVo;
			var preloaderBar:PreloaderBarMediator = this.facade.retrieveMediator(ViewMediatorNames.PreloaderBarMediator) as PreloaderBarMediator;
			if(preloaderBar && loadingDataVo)
			{
				preloaderBar.setProgress(loadingDataVo.loaded, loadingDataVo.total);
			}
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}