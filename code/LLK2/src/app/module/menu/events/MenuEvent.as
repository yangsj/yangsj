package app.module.menu.events
{
	import framework.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class MenuEvent extends BaseEvent
	{
		public function MenuEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const CLICK_MENU_START:String = "click_menu_start";
		
		public static const CLICK_MENU_HELP:String = "click_menu_help";
		
		public static const CLICK_MENU_RANK:String = "click_menu_rank";
		
		public static const CLICK_MENU_EXIT:String = "click_menu_exit";
		
	}
}