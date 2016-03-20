package app.chapter_06
{
	import code.SpriteBase;
	import code.chapter_06.VerletPoint;
	import code.chapter_06.VerletStick;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：VerletStrckTest
	 * @author victor
	 * 2012-8-19 上午11:16:19
	 */
	
	public class VerletStrckTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _pointA:VerletPoint;
		private var _pointB:VerletPoint;
		private var _stick:VerletStick;
		private var _stageRect:Rectangle;
		
		public function VerletStrckTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_stageRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			_pointA = new VerletPoint(100, 100);
			_pointB = new VerletPoint(105, 200);
			_stick = new VerletStick(_pointA, _pointB);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_pointA.y += 0.5;
			_pointA.update();
//			_pointA.constrain(_stageRect);
			
			_pointB.y += 0.5;
			_pointB.update();
//			_pointB.constrain(_stageRect);
			
			for (var i:int=0; i < 5; i++)
			{
				_pointA.constrain(_stageRect);
				_pointB.constrain(_stageRect);
				_stick.update();
			}
			
//			_stick.update();
			
			graphics.clear();
			_pointA.render(graphics);
			_pointB.render(graphics);
			_stick.render(graphics);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}