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
		/**
		 * 出现图片类型的随机范围值
		 */
		public var picNum:int = 15;
		/**
		 * 时间限制
		 */
		public var limitTime:int = 60;
		/**
		 * 当前等级每次消除所得的分数
		 */
		public var score:int = 100;
		
	}
}