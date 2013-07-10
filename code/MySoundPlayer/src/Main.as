package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import core.AppStatus;
	import core.Global;
	import core.main.systemIcon.SystemIconControl;
	import core.main.view.MainView;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-9
	 */
	public class Main extends Sprite
	{
		public function Main()
		{
			if ( stage )
				initApp();
			else
				addEventListener( Event.ADDED_TO_STAGE, initApp );
		}

		private function initApp( event:Event = null ):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Global.stage = stage;

			// create system icon
			new SystemIconControl();
			// setting
			new AppStatus();
			// add view
			addChild( new MainView());
		}
	}
}
