package app.startup
{
	import app.events.ViewEvent;
	import app.module.ViewName;
	
	import framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-6
	 */
	public class EnterCommand extends BaseCommand
	{
		public function EnterCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			dispatch( new ViewEvent(ViewEvent.SHOW_VIEW, ViewName.MENU ));
		}
		
	}
}