package app.module.setting
{
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
			
			
		}
		
		
	}
}