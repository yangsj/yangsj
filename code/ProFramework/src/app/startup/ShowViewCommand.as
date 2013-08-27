package app.startup
{
	import app.events.ViewEvent;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.interfaces.IView;


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
				var view:IView;
				if ( cls )
				{
					view = injector.getInstance( cls );
					if ( view )
					{
						if ( event.type == ViewEvent.SHOW_VIEW )
						{
							view.data = event.data;
							view.show();
						}
						else if ( event.type == ViewEvent.HIDE_VIEW )
						{
							view.hide();
						}
					}
				}
			}
		}
	}
}
