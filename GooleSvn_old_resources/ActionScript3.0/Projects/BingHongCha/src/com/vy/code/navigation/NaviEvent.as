package com.vy.code.navigation
{
	import flash.events.Event;
	
	
	/**
	 * 说明：NaviEvent
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-12
	 */
	
	public class NaviEvent extends Event
	{
		
		/////////////////////////////////static ////////////////////////////
		
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
		
		///////////////////////////////// vars /////////////////////////////////
		
		public var naviItem:NaviItem;
		
		public function NaviEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}