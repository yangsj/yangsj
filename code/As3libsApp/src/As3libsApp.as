package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import test.drag.TestDragView;
	import test.page.TestPageView;
	import test.scroll.TestScrollPanel;
	
	[SWF(width="800", height="480")]
	/**
	 * ……
	 * @author yangsj
	 */
	public class As3libsApp extends Sprite
	{
		public function As3libsApp()
		{
			if (stage)
				initApp();
			else addEventListener(Event.ADDED_TO_STAGE, initApp);
		}
		
		private function initApp(event:Event = null):void
		{
			
			// drag
//			addChild(new TestDragView());
			
			// scroll
//			addChild(new TestScrollPanel());
			
			// page
			addChild(new TestPageView());
			
		}
	}
}