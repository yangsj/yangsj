package victor.framework.loader.events
{
	import flash.events.Event;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class LoaderEvent extends Event
	{
		
		/**
		 * 完成加载
		 */
		public static const COMPLETE:String = "loader_event_complete";
		/**
		 * 开始加载
		 */
		public static const START:String = "loader_event_start";
		
		public function LoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}