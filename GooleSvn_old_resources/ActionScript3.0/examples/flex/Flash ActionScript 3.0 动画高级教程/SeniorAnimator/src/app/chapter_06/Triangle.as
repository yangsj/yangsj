package app.chapter_06
{
	import code.SpriteBase;
	import code.chapter_06.VerletPoint;
	import code.chapter_06.VerletStick;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：Triangle
	 * @author victor
	 * 2012-8-19 上午11:34:26
	 */
	
	public class Triangle extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _pointA:VerletPoint;
		private var _pointB:VerletPoint;
		private var _pointC:VerletPoint;
		private var _stickA:VerletStick;
		private var _stickB:VerletStick;
		private var _stickC:VerletStick;
		private var _stageRect:Rectangle;
		
		public function Triangle()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_stageRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			_pointA = new VerletPoint(100, 100);
			_pointB = new VerletPoint(200, 100);
			_pointC = new VerletPoint(150, 200);
			
			_stickA = new VerletStick(_pointA, _pointB);
			_stickB = new VerletStick(_pointB, _pointC);
			_stickC = new VerletStick(_pointC, _pointA);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_pointA.y += 0.5;
			_pointA.update();
			
			_pointB.y += 0.5;
			_pointB.update();
			
			_pointC.y += 0.5;
			_pointC.update();
			
			for (var i:int = 0; i < 1; i++)
			{
				_pointA.constrain(_stageRect);
				_pointB.constrain(_stageRect);
				_pointC.constrain(_stageRect);
				_stickA.update();
				_stickB.update();
				_stickC.update();
			}
			
			graphics.clear();
			_pointA.render(graphics);
			_pointB.render(graphics);
			_pointC.render(graphics);
			_stickA.render(graphics);
			_stickB.render(graphics);
			_stickC.render(graphics);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}