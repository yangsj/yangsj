package app.startup
{
	import app.events.ViewEvent;

	import framework.BaseCommand;
	import framework.BaseView;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-6
	 */
	public class ShowViewCommand extends BaseCommand
	{
		[Inject]
		public var event:ViewEvent;

		public function ShowViewCommand()
		{
			super();
		}

		override public function execute():void
		{
			if ( event )
			{
				var cls:Class = event.view as Class;
				var view:BaseView;
				if ( cls )
				{
					view = injector.getInstance( cls );
					if ( view )
					{
						view.data = event.data;
						view.show();
					}
				}
			}
		}
	}
}
