package pet.game.panels.continuousLanding.control.tabbutton
{
	import flash.events.Event;
	
	
	/**
	 * 说明：
	 * @author yangshengjin
	 */
	
	public class YsjTabButtonEvent extends Event
	{
		public var clickBtn:YsjTabMovieClipButton;
		public var nameType:String = "";
		
		public function YsjTabButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 点击
		 */
		static internal const TYPE_TARGET_CLICK:String = "type_target_click";
		
		/**
		 * ButtonManager 派发
		 */
		static public const BUTTON_EVENT_CLICK:String = "button_event_click";
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}