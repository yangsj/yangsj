package victor.astar
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-20
	 */
	public class AStarPoint
	{
		public function AStarPoint( x:int = 0, y:int = 0 )
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * cols标识列
		 */
		public var x:int = 0;
		
		/**
		 * rows标识行
		 */
		public var y:int = 0;

	}
}
