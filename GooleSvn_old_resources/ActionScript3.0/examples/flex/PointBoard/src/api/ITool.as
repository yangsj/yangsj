package api 
{
	import flash.events.*;
	
	/**
	 * ...
	 * @author King
	 */
	public interface ITool 
	{
		/**
		 * 
		 */
		function get option():IOption;
		function set option(value:IOption):void;
		
		/**
		 * 
		 */
		function get toolName():String;
		function set toolName(value:String):void;
		
		/**
		 * 
		 */
		function get paintBoard():IPaintBoard;
		function set paintBoard(value:IPaintBoard):void;
		
		/**
		 * 工具的绘图方法
		 * @param	e
		 */
		function draw(e:Event):void;
	}
	
}