package app.events
{
	import flash.events.Event;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-6
	 */
	public class ViewEvent extends Event
	{
		/**
		 * 类名称
		 */
		public var viewName:String;
		
		public var data:Object;
		
		public function ViewEvent(type:String, viewName:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.viewName = viewName;
			this.data = data;
		}
		
		/**
		 * 显示视图
		 */
		public static const SHOW_VIEW:String = "showViewByEventCommand";
		
		/**
		 * 关闭视图
		 */
		public static const HIDE_VIEW:String = "hideViewByEventCommand";
		
	}
}