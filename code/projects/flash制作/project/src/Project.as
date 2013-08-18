package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	
	import code.Main;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class Project extends Sprite
	{
		public function Project()
		{
			if ( stage ) 
				initApp();
			else addEventListener( Event.ADDED_TO_STAGE, initApp );
		}
		
		protected function initApp( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initApp );
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addChild( new Main());
			
//			var txt:TextField = new TextField();
//			txt.text = "author: victor    time: " + new Date().toString();
//			txt.width = txt.textWidth + 20;
//			txt.height = txt.textHeight + 3;
//			txt.x = stage.stageWidth - txt.width;
//			txt.y = stage.stageHeight - txt.height;
//			txt.selectable = false;
//			
//			addChild( txt );
//			
//			txt.alpha = 0.5;
			
		}
	}
}