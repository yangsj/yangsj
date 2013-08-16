package app.module.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-13
	 */
	public class Global
	{
		private static var _currentModule:uint;
		private static var _lastDownTime:Number = 0;
		
		public function Global()
		{
			super();
		}

		public static function get currentModule():uint
		{
			return _currentModule;
		}

		public static function set currentModule(value:uint):void
		{
			_currentModule = value;
		}

		public static function get lastDownTime():Number
		{
			return _lastDownTime;
		}

		public static function set lastDownTime(value:Number):void
		{
			_lastDownTime = value;
		}


	}
}