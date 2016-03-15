package net.victor.project.commands.loading
{
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.models.loading.LoadingBarDataVo;
	import net.victor.project.views.ViewMediatorNames;
	import net.victor.project.views.loading.LoadingBarMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * @param loadingDataVo 
	 * @see net.jt_tech.diamond.models.loading.LoadingBarDataVo
	 * @author jonee
	 * 
	 */	
	public class LoadingBarProgressCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function LoadingBarProgressCommand()
		{
			super();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			var loadingDataVo:LoadingBarDataVo = notification.body as LoadingBarDataVo;
			var loadingBarmediator:LoadingBarMediator = this.facade.retrieveMediator(ViewMediatorNames.LoadingBarMediator)  as LoadingBarMediator;
			if(loadingBarmediator && loadingDataVo)
			{
				loadingBarmediator.setProgress(loadingDataVo.loaded, loadingDataVo.total);
			}
		}
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}