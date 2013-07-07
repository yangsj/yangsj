package victor.data
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
		
		/**
		 *等级 
		 */
		public var level:int = 1;
		private var _picNum:int = 15;
		private var _limitTime:int = 60;
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
			_limitTime = Math.max(60, value);
		}


	}
}