package app.startup
{
	
	import app.module.KeyboardListener;
	
	import framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-13
	 */
	public class KeyboardCommand extends BaseCommand
	{
		
		public function KeyboardCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			new KeyboardListener();
		}
		
	}
}