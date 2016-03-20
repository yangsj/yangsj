package app.chapter_06
{
	import code.SpriteBase;
	import code.chapter_06.VerletPoint;
	import code.chapter_06.VerletStick;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：Hinge
	 * @author victor
	 * 2012-8-19 下午1:10:04
	 */
	
	public class Hinge extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _points:Array;
		private var _sticks:Array;
		private var _stageRect:Rectangle;
		
		public function Hinge()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_stageRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			_points = new Array();
			_sticks = new Array();
			
			const STAGE_WIDTH:Number = stage.stageWidth;
			const STAGE_HEIGHT:Number = stage.stageHeight;
			const HALF_WIDTH:Number = STAGE_WIDTH * 0.5;
			const HALF_HEIGHT:Number = STAGE_HEIGHT * 0.5;
			const EXCURSION:Number = 0;
			
			var pointA:VerletPoint = makePoint(HALF_WIDTH, STAGE_HEIGHT - 500);
			var pointB:VerletPoint = makePoint(EXCURSION, STAGE_HEIGHT);
			var pointC:VerletPoint = makePoint(STAGE_WIDTH - EXCURSION, STAGE_HEIGHT);
			
			var pointD:VerletPoint = makePoint(HALF_WIDTH + 350, STAGE_HEIGHT - 500);
			
			var pointE:VerletPoint = makePoint(HALF_WIDTH + 360, STAGE_HEIGHT - 510);
			var pointF:VerletPoint = makePoint(HALF_WIDTH + 360, STAGE_HEIGHT - 490);
			var pointG:VerletPoint = makePoint(HALF_WIDTH + 360, STAGE_HEIGHT - 500);
			
			pointA.vx = 10;
			
			makeStick(pointA, pointB);
			makeStick(pointB, pointC);
			makeStick(pointC, pointA);
			
			makeStick(pointA, pointD);
			
			makeStick(pointD, pointE);
			makeStick(pointD, pointF);
			makeStick(pointE, pointF);
			makeStick(pointE, pointG);
			makeStick(pointF, pointG);
			
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