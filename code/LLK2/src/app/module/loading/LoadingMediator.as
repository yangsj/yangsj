package app.module.loading
{
	import app.events.AppEvent;
	
	import framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-22
	 */
	public class LoadingMediator extends BaseMediator
	{
		[Inject]
		public var view:LoadingView;
		
		public function LoadingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( LoadingEvent.LOAD_COMPLETE, loadCompleteHandler, LoadingEvent );
		}
		
		private function loadCompleteHandler( event:LoadingEvent ):void
		{
			dispatch( new AppEvent( AppEvent.ENTER_GAME ));
			
			view.hide();
		}		
		
	}
}