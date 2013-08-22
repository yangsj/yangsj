package app.module
{
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import app.module.model.Global;
	
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
			NativeApplication.nativeApplication.addEventListener( KeyboardEvent.KEY_DOWN, keydownHandler, int.MAX_VALUE );
		}
		
		protected function keydownHandler( event:KeyboardEvent ):void
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
	}
}