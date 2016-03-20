package api 
{
	
	/**
	 * ...
	 * @author King
	 */
	public interface IControlBox 
	{
		function addControlTool(tool:IControl):void;
		function getControlToolIndex(index:int):IControl;		
		function getControlToolByName(name:String):IControl;		
		function get numControlTools():int;		
		function get toolControl():IControl;		
		function set toolControl(value:IControl):void;
	}
	
}