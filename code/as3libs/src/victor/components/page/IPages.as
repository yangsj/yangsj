package victor.components.page
{
	import victor.components.interfaces.IDispose;

	/**
	 * ……
	 * @author yangsj
	 */
	public interface IPages extends IDispose
	{
		/**
		 * 设置总数据
		 */
		function set items( value:Array ):void;

		/**
		 * 当前页数据
		 */
		function get curPage():Array;

		/**
		 * 上一页数据
		 */
		function get prevPage():Array;

		/**
		 * 下一页数据
		 */
		function get nextPage():Array;

		/**
		 * 页码显示格式 ： 1/1
		 */
		function get pageStr():String;

		/**
		 * 当前页码
		 */
		function get curPageNo():int;
		
		function set curPageNo(value:int):void;

		/**
		 * 总页码
		 */
		function get totalPageNo():int;

		/**
		 * 是否是第一页
		 */
		function get isFirstPage():Boolean;

		/**
		 * 是否是最后一页
		 */
		function get isLastPage():Boolean;
		
		/**
		 * 每页数据长度
		 */
		function get pageSize():int;
		
		/**
		 * 是否循环翻页（从第一页跳到最后一页， 最后一页跳至第一页）
		 */
		function get isLoop():Boolean;
		
		function set isLoop(value:Boolean):void;

	}
}
