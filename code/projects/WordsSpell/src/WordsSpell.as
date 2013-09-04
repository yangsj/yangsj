package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import app.AppContext;
	import app.utils.appStage;
	
	[SWF( width = "960", height = "560", frameRate = "30" )]
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class WordsSpell extends Sprite
	{
		public function WordsSpell()
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
			appStage.color = 0;
			
			new AppContext( this );
		}
	}
}