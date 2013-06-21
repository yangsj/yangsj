package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import test.astr.TestAStar;
	import test.drag.TestDragView;
	import test.page.TestPageView;
	import test.scroll.TestScrollPanel;

	[SWF( width = "960", height = "640" )]
	/**
	 * ……
	 * @author yangsj
	 */
	public class As3libsApp extends Sprite
	{
		public function As3libsApp()
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


			// drag
//			addChild(new TestDragView());

			// scroll
//			addChild(new TestScrollPanel());

			// page
//			addChild(new TestPageView());

			// aStar
			addChild( new TestAStar());

		}
	}
}
