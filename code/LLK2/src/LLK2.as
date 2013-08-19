package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import app.AppContext;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class LLK2 extends Sprite
	{
		public function LLK2()
		{
			if ( stage )
				initApp(null);
			else addEventListener( Event.ADDED_TO_STAGE, initApp);
		}
		
		protected function initApp(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initApp);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			new AppContext( this );
			
			 addChild ( new Test() );
		}
		
	}
}