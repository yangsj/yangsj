package api 
{
	
	/**
	 * ...
	 * @author King
	 */
	public interface IPenOption extends IOption
	{
		function get lineStyle():Number;
		function set lineStyle(value:Number):void;
		
		
		function get lineAlpha():Number;
		function set lineAlpha(value:Number):void;
		
		
		function get lineColor():uint;
		function set lineColor(value:uint):void;
	}
	
}