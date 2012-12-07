package network
{

	import flash.events.Event;


	/**
	 * 说明：ServiceEvent
	 * @author Victor
	 * 2012-10-23
	 */

	public class ServiceEvent extends Event
	{

		/**
		 * 网络连接正常
		 */
		public static const SERVICE_RIGHT:String = "service_right";
		
		/**
		 * 网络连接异常
		 */
		public static const SERVICE_ERROR:String = "service_error";
		
		
		public var data:Object;

		public function ServiceEvent(type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			if (data) 
			{
				this.data = data;
			}
		}



	}

}
