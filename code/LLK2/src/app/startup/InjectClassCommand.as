package app.startup
{
	import app.module.model.Global;
	
	import framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-6
	 */
	public class InjectClassCommand extends BaseCommand
	{
		public function InjectClassCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			injectActor( Global );
		}
	}
}