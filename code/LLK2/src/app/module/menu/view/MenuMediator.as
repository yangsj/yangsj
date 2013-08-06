package app.module.menu.view
{
	import app.events.ViewEvent;
	import app.module.ViewName;
	import app.module.menu.events.MenuEvent;

	import framework.BaseMediator;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class MenuMediator extends BaseMediator
	{
		public function MenuMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			super.onRegister();

			addViewListener( MenuEvent.CLICK_MENU_HELP, showHelpHandler );

			addViewListener( MenuEvent.CLICK_MENU_START, showMainHandler );

			addViewListener( MenuEvent.CLICK_MENU_RANK, showRankHandler );
		}

		private function showRankHandler( event:MenuEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.RANK ));
		}

		private function showMainHandler( event:MenuEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.MAIN ));
		}

		private function showHelpHandler( event:MenuEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.HELP ));
		}

	}
}
