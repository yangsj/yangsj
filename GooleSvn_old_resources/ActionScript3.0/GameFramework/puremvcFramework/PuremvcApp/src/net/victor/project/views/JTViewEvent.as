package net.victor.project.views
{
	import flash.events.Event;
	
	/**
	 * 面板中公用的事件 
	 * @author jonee
	 * 
	 */	
	public class JTViewEvent extends Event
	{
		/////////////////////////////////////////static /////////////////////////////////
		/**
		 * 面板关闭事件 
		 */		
		static public const PANEL_CLOSE:String = "panel_close";
		
		/**
		 * 点击确按钮
		 */		
		static public const BTN_CONFIRM_CLICK:String = "btn_confirm_click";
		
		/**
		 * 点击取消按钮 
		 */		
		static public const BTN_CANCEL_CLICK:String = "btn_cancel_click";
		
		/**
		 * 点击分享按钮 
		 */		
		static public const BTN_SHARE_CLICK:String = "btn_share_click";
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public var data:*;
		
		public function JTViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}