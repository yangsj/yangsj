package app.module.model
{
	import flash.system.Capabilities;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-13
	 */
	public class Global
	{
		private static var _currentModule:uint;
		private static var _lastDownTime:Number = 0;
		private static var _switchResultVibrate:Boolean = true;
		
		public function Global()
		{
			super();
		}

		public static function get lastDownTime():Number
		{
			return _lastDownTime;
		}

		public static function set lastDownTime(value:Number):void
		{
			_lastDownTime = value;
		}
		
		/**
		 * 是否是安卓平台
		 */
		public static function get isAndroid():Boolean
		{
			return (Capabilities.manufacturer.indexOf("Android") != -1);
		}
		
		/**
		 * 是否是ios平台
		 */
		public static function get isIOS():Boolean
		{
			return (Capabilities.manufacturer.indexOf("iOS") != -1);
		}

		/**
		 * 震动开关
		 */
		public static function get switchResultVibrate():Boolean
		{
			return _switchResultVibrate;
		}

		/**
		 * @private
		 */
		public static function set switchResultVibrate(value:Boolean):void
		{
			_switchResultVibrate = value;
		}


	}
}