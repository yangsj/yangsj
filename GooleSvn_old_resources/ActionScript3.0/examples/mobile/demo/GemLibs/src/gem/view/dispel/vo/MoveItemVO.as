package gem.view.dispel.vo
{
	import gem.view.dispel.Gem;
	
	/**
	 * 说明：MoveItemVO
	 * @author Victor
	 * 2012-10-8
	 */
	
	public class MoveItemVO
	{
		/**
		 * 钻石引用
		 */
		public var gems:Gem;
		public var rows:int;
		public var cols:int;
		/**
		 * 向下移动的单位数
		 */
		public var unit:int;
		
		public function MoveItemVO()
		{
		}
		
		
		
	}
	
}