package victor.framework.interfaces
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public interface IPanel extends IDisposable
	{
		function show():void;
		
		function hide():void;
		
		function get parent():DisplayObjectContainer;
	}
}