package core.diamonds
{
	
	/**
	 * 说明：GamePauseTotalTime
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-6-25
	 */
	
	public class GamePauseTotalTime
	{
		private static var _pauseTotalTime:Number = 0;
		private static var _dateTime:Number = 0;
		
		public function GamePauseTotalTime()
		{
		}
		
		public static function get changeToPropTime():Number
		{
			return Number(_pauseTotalTime / 6000);
		}

		public static function get pauseTotalTime():Number
		{
			return _pauseTotalTime;
		}
		
		public static function clears():void
		{
			_pauseTotalTime = 0;
			_dateTime = 0;
		}

		public static function pauseTime():void
		{
			_pauseTotalTime += new Date().time - _dateTime;
		}
		
		public static function startTime():void
		{
			_dateTime = new Date().time;
		}
		
	}
	
}