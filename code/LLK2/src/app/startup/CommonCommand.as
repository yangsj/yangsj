package app.startup
{
	import app.events.AppEvent;
	import app.events.ViewEvent;
	
	import framework.BaseCommand;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-6
	 */
	public class CommonCommand extends BaseCommand
	{
		public function CommonCommand()
		{
			super();
		}

		override public function execute():void
		{

			commandMap.mapEvent( ViewEvent.SHOW_VIEW, ShowViewCommand, ViewEvent );
			
			commandMap.mapEvent( AppEvent.ENTER_GAME, EnterCommand, AppEvent, true );
			
			commandMap.mapEvent( AppEvent.CHECK_UPDATE, CheckUpdaterCommand, AppEvent );

		}

	}
}
