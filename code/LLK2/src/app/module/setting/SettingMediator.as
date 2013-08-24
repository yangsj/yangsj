package app.module.setting
{
	import app.events.AppEvent;
	
	import framework.BaseMediator;
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class SettingMediator extends BaseMediator
	{
		[Inject]
		public var view:SettingView;
		
		public function SettingMediator()
		{
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( AppEvent.CHECK_UPDATE, checkUpdateHandler, AppEvent );
		}
		
		private function checkUpdateHandler( event:AppEvent ):void
		{
			dispatch( event );
			
			view.hide();
		}
		
		
	}
}