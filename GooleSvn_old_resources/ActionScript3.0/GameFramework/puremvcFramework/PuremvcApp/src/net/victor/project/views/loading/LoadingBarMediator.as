package net.victor.project.views.loading
{
	import net.victor.project.views.ViewMediatorBase;
	
	public class LoadingBarMediator extends ViewMediatorBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _loadingBarView:LoadingBarView;
		public function LoadingBarMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			initViews();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		public function setProgress(current:Number, total:Number):void
		{
			_loadingBarView.setProgress(current, total);
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override protected function initAbstract():void
		{
			
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		protected function initViews():void
		{
			_loadingBarView = new LoadingBarView();
			this.viewers.push(_loadingBarView);
			_loadingBarView.x = (appStage.stageWidth - _loadingBarView.width) / 2;
			_loadingBarView.y = (appStage.stageHeight - _loadingBarView.height) / 2;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}