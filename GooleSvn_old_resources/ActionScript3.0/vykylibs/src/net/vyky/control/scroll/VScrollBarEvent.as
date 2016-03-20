package net.vyky.control.scroll
{
	import flash.events.Event;
	
	/**
	 * ...
	 * ScrollBar
	 * @author KingYang
	 * @qq 729264471
	 * @email acsh_ysj@163.com
	 */
	public class VScrollBarEvent extends Event
	{
		/** 当滑块移动，并不是被拖动的情况下，调度事件 */
		public static const SCROLLBAR_CHENGE:String     = 'scrollBarChange';
		/** 当滑块被拖动时调度事件 */
		public static const SCROLLBAR_DRAG:String       = 'scrollBarDrag';
		/** 当在滑块上按下鼠标时调度事件 */
		public static const SCROLLBAR_PRESS_DOWN:String = 'scrollBarPressDown';
		/** 当鼠标从滑块上弹起时调度事件 */
		public static const SCROLLBAR_PRESS_UP:String   = 'scrollBarPressUp';
		
		
		private var _data:Object;
		
		public function VScrollBarEvent(type:String, $data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_data = $data;
		} 
		
		public override function clone():Event 
		{ 
			return new VScrollBarEvent(type, bubbles, cancelable);
		} 
		
		public function get data():Object { return _data; }
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
	}
	
}