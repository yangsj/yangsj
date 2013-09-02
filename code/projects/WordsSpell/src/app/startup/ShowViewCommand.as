package app.startup
{
	import app.events.ViewEvent;
	import app.utils.error;
	
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
				var viewName:String = event.viewName;
				var view:IView;
				if ( viewName )
				{
					var cls:Class = getViewByName(viewName ) as Class;
					if ( cls )
					{
						view = injector.getInstance( cls );
						if ( view )
						{
							if ( event.type == ViewEvent.SHOW_VIEW )
							{
								view.data = event.data;
								if ( view.parent == null )
									view.show();
								else view.refresh();
							}
							else if ( event.type == ViewEvent.HIDE_VIEW )
							{
								if ( view.parent )
									view.hide();
							}
						}
					}
					else
					{
						error( "找不到[" + viewName + "]绑定的类" );
					}
				}
				else
				{
					error( "viewName不存在！" );
				}
			}
		}
	}
}
