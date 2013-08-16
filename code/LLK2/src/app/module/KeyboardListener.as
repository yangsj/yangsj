package app.module
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import app.AppStage;
	import app.module.model.Global;
	import app.utils.safetyCall;
	
	import framework.ViewStruct;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-13
	 */
	public class KeyboardListener
	{
		private var callBack:Function;
		public function KeyboardListener()
		{
			AppStage.stage.addEventListener( KeyboardEvent.KEY_DOWN, keydownHandler, int.MAX_VALUE );
		}
		
		protected function keydownHandler( event:KeyboardEvent ):void
		{
			var keyCode:uint = event.keyCode;
			if ( keyCode == Keyboard.BACK )
			{
//				if ( Global.currentModule == GlobalType.MODULE_MENU )
//				{
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
//				}
//				else if (Global.currentModule == GlobalType.MODULE_MAIN )
//				{
//					event.preventDefault();
//					safetyCall( callBack );
//				}
			}
		}	
	}
}