package app.modules.login.preloader
{
	import app.events.LoadEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class PreloaderMediator extends BaseMediator
	{
		[Inject]
		public var view:PreloaderView;
		
		public function PreloaderMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( LoadEvent.LOAD_PROGRESS, loadProgressHandler, LoadEvent );
		}
		
		private function loadProgressHandler( event:LoadEvent ):void
		{
			view.setProgressValue( Number( event.data ) );
		}
		
	}
}