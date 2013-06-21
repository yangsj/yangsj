package victor.core
{
	import victor.core.interfaces.IDisposable;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-6-21
	 */
	public interface IElement extends IDisposable
	{
		/**
		 * 列数编号
		 */
		function get cols():int;
		function set cols(value:int):void;
		
		/**
		 * 行号编号
		 */
		function get rows():int;
		function set rows(value:int):void;
		
		/**
		 * 是否是存在的
		 */
		function get isReal():Boolean;
		function set isReal(value:Boolean):void;
		
		
		
	}
}