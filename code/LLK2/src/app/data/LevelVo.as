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
			_picNum = Math.min(value, 21);
			_picNum = Math.max( _picNum, 12 );
			
//			_picNum = 1;
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

		public function get directionString():String
		{
			return ["无方向", "单向向下", "单向向上", "单向向左", "单向向右", 
				"双向下上（左右分半）", "双向左右（上下分半）", "双向上下（左右分半）", "双向右左（上下分半）", 
				"右上（列向右靠，向上移动）", "右下（列向右靠，向下移动）", "左上（列向左靠，向上移动）", "左下（列向左靠，向下移动）", "上左（行向上靠，向左移动）", "上右（行向上靠，向右移动）", "下左（行向下靠，向左移动）", "下右（行向下靠，向右移动）", 
				"左下角", "右下角", "左上角", "右上角", "中下靠", "中上靠", "中左靠", "右中靠", "行列向中间靠"][ direction ];
		}

	}
}