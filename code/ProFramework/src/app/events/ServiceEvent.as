package app.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class ServiceEvent extends BaseEvent
	{
		public function ServiceEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		
		/**
		 * 网络连接的
		 */
		public static const CONNECTED:String = "service_event_connected";
		
		/**
		 * 连接失败
		 */
		public static const FAILED:String = "service_event_failed";
		
		/**
		 * 连接关闭
		 */
		public static const CLOSED:String = "service_event_closed";
		
	}
}