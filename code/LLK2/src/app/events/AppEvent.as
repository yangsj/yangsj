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
		
//		public static const SHOW_VIEW:String = "display_view";
		
		
	}
}