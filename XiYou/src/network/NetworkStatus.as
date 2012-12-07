package network
{
	import air.net.URLMonitor;
	
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	
	/**
	 * 说明：主要检查网络的可用性，可用available的值判定。应用初始化是通过start方法启动检查网络状态程序
	 * @author Victor
	 * 2012-10-25
	 */
	
	public class NetworkStatus
	{
		private static const URL:String = "http://www.jt-tech.net";
		
		private static var _available:Boolean = true;
		private static var _monitor:URLMonitor;
		
		public function NetworkStatus()
		{
		}
		
		public static function start():void
		{
			if (_monitor == null)
			{
				_monitor = new URLMonitor(new URLRequest(URL));
				_monitor.addEventListener(StatusEvent.STATUS, onStatusHandler);
				_monitor.start();
			}
		}
		
		protected static function onStatusHandler(event:StatusEvent):void
		{
			if (event.level == "status")
			{
				if (_monitor)
				{
					_available = _monitor.available;
				}
			}
			else
			{
				_available = false;
			}
		}		
		
		/**
		 * 当前网络是否是可用状态
		 */
		public static function get available():Boolean
		{
			return _available;
		}

	}
	
}