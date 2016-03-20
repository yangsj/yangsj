package app.chapter_06
{
	import code.SpriteBase;
	import code.chapter_06.VerletPoint;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：VerletPointTest
	 * @author victor
	 * 2012-8-12 上午10:23:41
	 */
	
	public class VerletPointTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _point:VerletPoint;
		private var _rect:Rectangle;
		
		public function VerletPointTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_rect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);			
			_point = new VerletPoint(100, 100);
			_point.x += 5;
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_point.y += 0.5;
			_point.update();
			_point.constrain(_rect);
			graphics.clear();
			_point.render(graphics);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}