package victor.astar
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-6-20
	 */
	public class AStarItem
	{
		public function AStarItem()
		{
		}
		
		/**
		 * 是否是起始节点
		 */
		public var isStart:Boolean = false;
		/**
		 * 是否是结束节点
		 */
		public var isEnd:Boolean = false;
		
		/**
		 * 是否是不能通过的
		 */
		public var isBlock:Boolean;
		/**
		 * 是否能通过
		 */
		public var isCan:Boolean = true;
		
		/**
		 * cols标识列
		 */
		public var x:int = 0;
		
		/**
		 * rows标识行
		 */
		public var y:int = 0;
		
		/**
		 * 
		 */
		public var f:int = 0;
		/**
		 * 从起点沿着已生成的路径到一个给定方格的移动开销。
		 */
		public var g:int = 0;
		/**
		 * 从给定方格到目的方格的估计移动开销
		 */
		public var h:int = 0;
		/**
		 * 父节点
		 */
		public var parentNode:AStarItem;
		
	}
}