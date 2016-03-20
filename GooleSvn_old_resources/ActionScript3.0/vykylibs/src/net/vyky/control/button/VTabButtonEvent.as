package net.vyky.control.button
{
	import flash.events.Event;
	
	
	/**
	 * 说明：ButtonEvent<br>
	 * 作者：杨胜金<br>
	 * QQ729264471<br>
	 * 2011-11-2 下午10:42:20
	 */
	
	public class VTabButtonEvent extends Event
	{
		public var clickBtn:VTabMovieClipButton;
		public var nameType:String = "";
		
		public function VTabButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
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