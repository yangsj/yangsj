package api 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author King
	 */
	public interface IControl 
	{
		function get toolControlName():String;
		function set toolControlName(value:String):void;
		
		function get paintBoard():IPaintBoard;
		function set paintBoard(value:IPaintBoard):void;
		
		function draw(e:Event):void;
	}
	
}