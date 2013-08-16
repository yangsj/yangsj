package app.module.main.view
{
	import flash.events.KeyboardEvent;
	
	import app.AppStage;
	import app.events.ViewEvent;
	import app.module.GlobalType;
	import app.module.ViewName;
	import app.module.main.events.MainEvent;
	import app.module.model.Global;
	
	import framework.BaseMediator;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class MainMediator extends BaseMediator
	{
		[Inject]
		public var view:MainView;
		
		public function MainMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.MENU ));
		}

		override public function onRegister():void
		{
			super.onRegister();

			addViewListener( MainEvent.BACK_MENU, backMenuHandler, MainEvent );
			addContextListener( MainEvent.BACK_MENU, backMenuHandler, MainEvent );
			
			Global.currentModule = GlobalType.MODULE_MAIN;
		}
		
		private function backMenuHandler( event:MainEvent ):void
		{
			view.backMenu();
		}

	}
}
