package app.startup
{
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class FlashVarsCommand extends BaseCommand
	{
		public function FlashVarsCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var parameters:Object = contextView.stage.loaderInfo.parameters;
			
		}
	}
}