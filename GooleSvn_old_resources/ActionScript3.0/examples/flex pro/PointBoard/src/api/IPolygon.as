package api 
{
	
	/**
	 * ...
	 * @author King
	 */
	public interface IPolygon  extends IOption
	{
		function get hasBorder():Boolean;
		function set hasBorder(value:Boolean):void;
		
		function get lineStyle():Number;
		function set lineStyle(value:Number):void;		
		
		function get lineAlpha():Number;
		function set lineAlpha(value:Number):void;		
		
		function get lineColor():uint;
		function set lineColor(value:uint):void;
		
		
		function get hasFill():Boolean;
		function set hasFill(value:Boolean):void;
		
		function get fillColor():uint;
		function set fillColor(value:uint):void;		
		
		function get fillAlpha():Number;
		function set fillAlpha(value:Number):void;
	}
	
}