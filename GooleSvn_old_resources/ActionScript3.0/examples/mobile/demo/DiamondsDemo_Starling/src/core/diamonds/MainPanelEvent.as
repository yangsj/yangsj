package core.diamonds
{
	import flash.events.Event;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-11-28 下午03:43:42
	 */
	public class MainPanelEvent extends Event
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		public var totalResultNum:Number = 0;
		
		public function MainPanelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 菜单按钮  menu
		 */
		static public const BUTTON_CLICK_MENUBTN:String = "button_click_menuBtn";
		
		/**
		 * 游戏结束
		 */
		static public const GAME_OVER:String = "game_over";
		
		/**
		 * 檢測到作弊，非法手段
		 */
		static public const CHECK_CHEAT:String = "check_cheat";
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}