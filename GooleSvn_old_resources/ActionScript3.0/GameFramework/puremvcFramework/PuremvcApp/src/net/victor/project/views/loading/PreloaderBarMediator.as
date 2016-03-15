package net.victor.project.views.loading
{
	import net.victor.project.views.ViewMediatorBase;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-19 下午01:14:54
	 */
	public class PreloaderBarMediator extends ViewMediatorBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var preloaderView:PreloaderBarView;
		
		public function PreloaderBarMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			initViews();
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function setProgress(current:Number, total:Number):void
		{
			preloaderView.setProgress(current, total);
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override protected function initAbstract():void
		{
			
		}
		
		override public function dispose():void
		{
			
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		protected function initViews():void
		{
			preloaderView = new PreloaderBarView();
			this.viewers.push(preloaderView);
			preloaderView.x = (appStage.stageWidth - preloaderView.width) / 2;
			preloaderView.y = (appStage.stageHeight - preloaderView.height) / 2;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}