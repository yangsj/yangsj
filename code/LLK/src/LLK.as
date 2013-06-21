package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import victor.view.SceneView;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-6-21
	 */
	public class LLK extends Sprite
	{
		public function LLK()
		{
			if (stage)
				initApp();
			else addEventListener(Event.ADDED_TO_STAGE, initApp);
		}
		
		protected function initApp(event:Event = null):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var view:SceneView = new SceneView();
			addChild(view);
			view.startAndReset();
			
		}
	}
}