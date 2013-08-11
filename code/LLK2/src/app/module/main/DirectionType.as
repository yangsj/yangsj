package app.module.main
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-7
	 */
	public class DirectionType
	{
		public function DirectionType()
		{
		}

		private static var num:uint = 0;
		/**
		 * 默认：无方向
		 */
		public static const DEFAULT:uint = num++;
		
/////
		
		/**
		 * 单向向下
		 */
		public static const DOWN:uint = num++;
		/**
		 * 单向向上
		 */
		public static const UP:uint = num++;
		/**
		 * 单向向左
		 */
		public static const LEFT:uint = num++;
		/**
		 * 单向向右
		 */
		public static const RIGHT:uint = num++;
		
/////
		
		/**
		 * 双向下上（左右分半）
		 */
		public static const downAndUp:uint = num++;
		
		/**
		 * 双向左右（上下分半）
		 */
		public static const leftAndRight:uint = num++;

		/**
		 * 双向上下（左右分半）
		 */
		public static const upAndDown:uint = num++;

		/**
		 * 双向右左（上下分半）
		 */
		public static const rightAndLeft:uint = num++;
		
/////
		
		/**
		 * 右上（列向右靠，向上移动）
		 */
		public static const byRightMoveUp:uint = num++;
		/**
		 * 右下（列向右靠，向下移动）
		 */
		public static const byRightMoveDown:uint = num++;
		/**
		 * 左上（列向左靠，向上移动）
		 */
		public static const byLeftMoveUp:uint = num++;
		/**
		 * 左下（列向左靠，向下移动）
		 */
		public static const byLeftMoveDown:uint = num++;
		/**
		 * 上左（行向上靠，向左移动）
		 */
		public static const byUpMoveLeft:uint = num++;
		/**
		 * 上右（行向上靠，向右移动）
		 */
		public static const byUpMoveRight:uint = num++;
		/**
		 * 下左（行向下靠，向左移动）
		 */
		public static const byDownMoveLeft:uint = num++;
		/**
		 * 下右（行向下靠，向右移动）
		 */
		public static const byDownMoveRight:uint = num++;
		
///////
		
		/**
		 * 左下角
		 */
		public static const moveDownLeft:int = num++;
		/**
		 * 右下角
		 */
		public static const moveDownRight:int = num++;
		/**
		 * 左上角
		 */
		public static const moveUpLeft:int = num++;
		/**
		 * 右上角
		 */
		public static const moveUpRight:int = num++;
		
///////
		
		/**
		 * 中下靠
		 */
		public static const byCenterFromLeftAndRightThenMoveDown:uint = num++;
		
		/**
		 * 中上靠
		 */
		public static const byCenterFromLeftAndRightThenMoveUp:uint = num++;
		
		/**
		 * 中左靠
		 */
		public static const byCenterFromUpAndDownThenMoveLeft:uint = num++;
		
		/**
		 * 右中靠
		 */
		public static const byCenterFromUpAndDownThenMoveRight:uint = num++;
		
//		/**
//		 * 列向中间靠
//		 */
//		public static const byCenterFromLeftAndRight:uint = num++;
//		
//		/**
//		 * 行向中间靠
//		 */
//		public static const byCenterFromUpAndDown:uint = num++;
		
		/**
		 * 行列向中间靠
		 */
		public static const byCenterFromLeftAndRightAndUpAndDown:uint = num++;

		public static const MAX:uint = num;

	}
}
