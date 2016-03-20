package api 
{
	
	/**
	 * ...
	 * @author King
	 */
	public interface ICommand 
	{
		function redo():void;
		function undo():void;
		
		function init(tool:ITool, art:IArt):void;
	}
	
}