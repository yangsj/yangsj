package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.Global;
	import core.main.systemIcon.SystemIconControl;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-7-9
	 */
	public class Main extends Sprite
	{
		public function Main()
		{
			if (stage)
				initApp();
			else addEventListener(Event.ADDED_TO_STAGE, initApp);
		}
		
		private function initApp(event:Event = null):void
		{
			Global.stage = stage;
			
			// create system icon
			new SystemIconControl();
		}
	}
}