package app.data
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-7-3
	 */
	public class LevelVo
	{
		public function LevelVo()
		{
		}
		
		private var _level:int = 1;
		private var _picNum:int = 15;
		private var _limitTime:int = 60;
		private var _direction:uint;
		/**
		 * 当前等级每次消除所得的分数
		 */
		public var score:int = 100;
		
		/**
		 * 出现图片类型的随机范围值
		 */
		public function get picNum():int
		{
			return _picNum;
		}

		/**
		 * @private
		 */
		public function set picNum(value:int):void
		{
			_picNum = Math.min(value, 40);
		}

		/**
		 * 时间限制
		 */
		public function get limitTime():int
		{
			return _limitTime;
		}

		/**
		 * @private
		 */
		public function set limitTime(value:int):void
		{
			_limitTime = value;//Math.max(60, value);
		}

		/**
		 * 移动方向
		 */
		public function get direction():uint
		{
			return _direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:uint):void
		{
			_direction = value;
		}

		/**
		 *等级 
		 */
		public function get level():int
		{
			return _level;
		}

		/**
		 * @private
		 */
		public function set level(value:int):void
		{
			_level = value;
		}


	}
}