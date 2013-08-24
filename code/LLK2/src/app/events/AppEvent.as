package app.events
{
	import framework.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class AppEvent extends BaseEvent
	{
		public function AppEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const BG_MUSIC:String = "back_ground_music";
		
		public static const ENTER_GAME:String = "enter_game";
		
		public static const CHECK_UPDATE:String = "check_update";
		
		public static const DOWNLOAD_APP:String = "download_app";
		
		
	}
}