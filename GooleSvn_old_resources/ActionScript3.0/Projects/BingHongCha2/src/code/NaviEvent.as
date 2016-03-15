package code
{
	import flash.events.Event;
	
	
	/**
	 * 说明：NaviEvent
	 * @author victor
	 * 2012-5-29 上午12:47:26
	 */
	
	public class NaviEvent extends Event
	{
		
		////////////////// vars /////////////////////////////////
		
		/**
		 * 点击Item
		 */
		static public const CLICK_ITEM:String = "click_item";
		
		/**
		 * 鼠标移上item
		 */
		static public const OVER_ITEM:String = "over_item";
		
		/**
		 * 鼠标离开Item
		 */
		static public const OUT_ITEM:String = "out_item";
		
		
		public var naviItem:ElementsItem;
		
		public function NaviEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}