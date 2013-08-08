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

		public static const DOWN:uint = num++;

		public static const UP:uint = num++;

		public static const LEFT:uint = num++;

		public static const RIGHT:uint = num++;

		public static const DOWN_UP:uint = num++;

		public static const LEFT_RIGHT:uint = num++;
		
		public static const byDown:uint = num++;
		
		public static const byUp:uint = num++;
		
		public static const byLeft:uint = num++;
		
		public static const byRight:uint = num++;
		
		public static const byRightMoveUp:uint = num++;
		
		public static const byRightMoveDown:uint = num++;
		
		public static const byLeftMoveUp:uint = num++;
		
		public static const byLeftMoveDown:uint = num++;
		
		public static const byUpMoveLeft:uint = num++;
		
		public static const byUpMoveRight:uint = num++;
		
		public static const byDownMoveLeft:uint = num++;
		
		public static const byDownMoveRight:uint = num++;

		public static const MAX:uint = num;

	}
}
