package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import app.AppContext;


	[SWF( width = "760", height = "600", frameRate = "30" )]

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-27
	 */
	public class AppMain extends Sprite
	{
		public function AppMain()
		{
			if ( stage )
				initApp();
			else addEventListener( Event.ADDED_TO_STAGE, initApp );
		}
		
		private function initApp( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initApp );
			
			appStage = stage;
			appStage.align = StageAlign.TOP_LEFT;
			appStage.scaleMode = StageScaleMode.NO_SCALE;
			
			new AppContext( this );
		}
	}
}
