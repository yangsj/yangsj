package app.module.menu.view
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import app.AppStage;
	import app.events.ViewEvent;
	import app.module.GlobalType;
	import app.module.ViewName;
	import app.module.menu.events.MenuEvent;
	import app.module.model.Global;
	import app.utils.safetyCall;
	
	import framework.BaseMediator;
	import framework.ViewStruct;


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
		
		override public function onRemove():void
		{
			super.onRemove();
			
			AppStage.stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardHandler );
		}

		override public function onRegister():void
		{
			super.onRegister();

			addViewListener( MenuEvent.CLICK_MENU_HELP, showHelpHandler );

			addViewListener( MenuEvent.CLICK_MENU_START, showMainHandler );

			addViewListener( MenuEvent.CLICK_MENU_RANK, showRankHandler );
			
			addViewListener( MenuEvent.CLICK_MENU_SETTING, showSettingHandler );
			
			Global.currentModule = GlobalType.MODULE_MENU;
			
//			AppStage.stage.addEventListener( KeyboardEvent.KEY_DOWN, keyboardHandler, int.MAX_VALUE );
		}
		
		protected function keyboardHandler(event:KeyboardEvent):void
		{
			var keyCode:uint = event.keyCode;
			if ( keyCode == Keyboard.BACK )
			{
				var cha:Number = getTimer() - Global.lastDownTime;
				if ( Global.lastDownTime == 0 || cha > 1500 )
				{
					event.preventDefault();
					
					ViewStruct.addBackWordEffect();
					Global.lastDownTime = getTimer();
				}
				else if ( cha <= 1500 )
				{
					ViewStruct.removeBackWordEffect();
					Global.lastDownTime = 0;
				}
			}
		}
		
		private function showSettingHandler( event:MenuEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.SETTING ));
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
