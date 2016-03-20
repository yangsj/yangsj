package app.chapter_06
{
	import code.SpriteBase;
	import code.chapter_06.VerletPoint;
	import code.chapter_06.VerletStick;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：Square2
	 * @author victor
	 * 2012-8-19 下午12:45:46
	 */
	
	public class Square2 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _points:Array;
		private var _sticks:Array;
		private var _stageRect:Rectangle;
		
		public function Square2()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_stageRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			_points = new Array();
			_sticks = new Array();
			
			var pointA:VerletPoint = makePoint(100, 100);
			var pointB:VerletPoint = makePoint(200, 100);
			var pointC:VerletPoint = makePoint(200, 200);
			var pointD:VerletPoint = makePoint(100, 200);
			
			pointA.vx = 10;
			
			makeStick(pointA, pointB);
			makeStick(pointB, pointC);
			makeStick(pointC, pointD);
			makeStick(pointD, pointA);
			makeStick(pointA, pointC);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			updatePoints();
			for (var i:int = 0; i < 1; i++)
			{
				constrainPoints();
				updateSticks();
			}
			graphics.clear();
			renderPoints();
			renderSticks();
		}
		
		private function makePoint(xpos:Number, ypos:Number):VerletPoint
		{
			var point:VerletPoint = new VerletPoint(xpos, ypos);
			_points.push(point);
			return point;
		}
		
		private function makeStick(pointA:VerletPoint, pointB:VerletPoint, length:Number=-1):VerletStick
		{
			var stick:VerletStick = new VerletStick(pointA, pointB, length);
			_sticks.push(stick);
			return stick;
		}
		
		private function updatePoints():void
		{
			for each (var point:VerletPoint in _points)
			{
				if (point)
				{
					point.y += 0.5;
					point.update();
				}
			}
		}
		
		private function constrainPoints():void
		{
			for each (var point:VerletPoint in _points)
			{
				if (point)
				{
					point.constrain(_stageRect);
				}
			}
		}
		
		private function updateSticks():void
		{
			for each (var stick:VerletStick in _sticks)
			{
				if (stick) stick.update();
			}
		}
		
		private function renderPoints():void
		{
			for each (var point:VerletPoint in _points)
			{
				if (point) point.render(graphics);
			}
		}
		
		private function renderSticks():void
		{
			for each (var stick:VerletStick in _sticks)
			{
				if ( stick ) stick.render(graphics);
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}