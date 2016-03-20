package core 
{
	import api.IArt;
	import api.ICommand;
	import api.ITool;
	
	/**
	 * ...
	 * @author King
	 */
	public class Command implements ICommand 
	{
		private var _tool:ITool;
		private var _art:IArt;
		
		public function Command() 
		{
			
		}
		
		/* INTERFACE api.ICommand */
		
		public function redo():void 
		{
			
		}
		
		public function undo():void 
		{
			
		}
		
		public function init(tool:ITool, art:IArt):void 
		{
			_tool = tool;
			_art  = art;
			
			//redo();
		}
		
	}

}