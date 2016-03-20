package app.chapter_06
{
	import code.SpriteBase;
	import code.chapter_06.VerletPoint;
	import code.chapter_06.VerletStick;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：Square
	 * @author victor
	 * 2012-8-19 下午12:15:58
	 */
	
	public class Square extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _pointA:VerletPoint;
		private var _pointB:VerletPoint;
		private var _pointC:VerletPoint;
		private var _pointD:VerletPoint;
		private var _pointE:VerletPoint;
		private var _pointF:VerletPoint;
		private var _stickA:VerletStick;
		private var _stickB:VerletStick;
		private var _stickC:VerletStick;
		private var _stickD:VerletStick;
		private var _stickE:VerletStick;
		private var _stickF:VerletStick;
		private var _stageRect:Rectangle;
		
		public function Square()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_stageRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			_pointA = new VerletPoint(100, 100);
			_pointB = new VerletPoint(200, 100);
			_pointC = new VerletPoint(200, 200);
			_pointD = new VerletPoint(100, 200);
			
			_pointA.vx = 10;
			
			_stickA = new VerletStick(_pointA, _pointB);
			_stickB = new VerletStick(_pointB, _pointC);
			_stickC = new VerletStick(_pointC, _pointD);
			_stickD = new VerletStick(_pointD, _pointA);
			_stickE = new VerletStick(_pointA, _pointC);
			_stickF = new VerletStick(_pointB, _pointD);
			
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
			
			_pointD.y += 0.5;
			_pointD.update();
			
			for (var i:int = 0; i < 1; i++)
			{
				_pointA.constrain(_stageRect);
				_pointB.constrain(_stageRect);
				_pointC.constrain(_stageRect);
				_pointD.constrain(_stageRect);
				_stickA.update();
				_stickB.update();
				_stickC.update();
				_stickD.update();
				_stickE.update();
				_stickF.update();
			}
			
			graphics.clear();
			_pointA.render(graphics);
			_pointB.render(graphics);
			_pointC.render(graphics);
			_pointD.render(graphics);
			_stickA.render(graphics);
			_stickB.render(graphics);
			_stickC.render(graphics);
			_stickD.render(graphics);
			_stickE.render(graphics);
			_stickF.render(graphics);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}