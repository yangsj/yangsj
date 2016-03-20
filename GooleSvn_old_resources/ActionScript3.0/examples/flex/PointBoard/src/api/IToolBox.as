package api 
{
	
	/**
	 * ...
	 * @author King
	 */
	public interface IToolBox 
	{
		/**
		 * 添加工具到工具箱中
		 * @param	tool
		 */
		function addTool(tool:ITool):void;		
		
		/**
		 * 按索引返回所指定的工具
		 * @param	index
		 * @return
		 */
		function getToolIndex(index:int):ITool;		
		
		/**
		 * 若存在与参数name相同名字的工具，则返回该工具，否则返回一个新实例化的工具。
		 * @param	name
		 * @return
		 */
		function getToolByName(name:String):ITool;		
		
		/**
		 * 
		 */
		function get numTools():int;	
		
		/**
		 * 
		 */
		function get tool():ITool;	
		
		/**
		 * 
		 */
		function set tool(value:ITool):void;
	}
	
}