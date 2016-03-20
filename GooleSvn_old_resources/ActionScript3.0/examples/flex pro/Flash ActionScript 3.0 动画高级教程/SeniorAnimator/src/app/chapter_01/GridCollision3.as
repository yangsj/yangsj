package app.chapter_01
{
	import code.chapter_01.CollisionGrid;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.resource.Ball;
	
	
	/**
	 * 说明：GridCollision3
	 * @author victor
	 * 2012-4-8 下午08:37:39
	 */
	
	public class GridCollision3 extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private const GRID_SIZE:Number = 80;
		private const RADIUS:Number = 25;
		
		private var _balls:Vector.<DisplayObject>;
		private var _grid:CollisionGrid;
		private var _numBalls:int = 100;
		
		public function GridCollision3()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		private function addedToStageHandler(e:Event):void
		{
			_grid = new CollisionGrid(this.stage.stageWidth, this.stage.stageHeight, GRID_SIZE);
			_grid.drawGrid(this.graphics);
			makeBalls();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		private function onEnterFrame(e:Event):void
		{
//			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			updateBalls();
			_grid.check(_balls);
			var numChecks:int = _grid.checks.length;
			for (var j:int = 0; j < numChecks; j += 2)
			{
				checkCollision(_grid.checks[j] as Ball, _grid.checks[j + 1] as Ball);
			}
		}
		
		private function makeBalls():void
		{
			_balls = new Vector.<DisplayObject>(_numBalls);
			for (var i:int = 0; i < _numBalls; i++)
			{
				var ball:Ball = new Ball(10 + (RADIUS - 10) * Math.random());
				ball.x = Math.random() * stage.stageWidth;
				ball.y = Math.random() * stage.stageHeight;
				ball.vx = Math.random() * 4 - 2;
				ball.vy = Math.random() * 4 - 2;
				addChild(ball);
				_balls[i] = ball;
			}
		}
		
		private function checkCollision(ballA:Ball, ballB:Ball):void
		{
			var dx:Number = ballB.x - ballA.x;
			var dy:Number = ballB.y - ballA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if (dist <= ballA.radius + ballB.radius)
			{
				ballA.color = 0xff0000;
				ballB.color = 0xff0000;
			}
		}
		
		private function updateBalls():void
		{
			for (var i:int = 0; i < _numBalls; i++)
			{
				var ball:Ball = _balls[i] as Ball;
				ball.update();
				if (ball.x < ball.radius)
				{
					ball.x = ball.radius;
					ball.vx *= -1;
				}
				else if (ball.x > stage.stageWidth - ball.radius)
				{
					ball.x = stage.stageWidth - ball.radius;
					ball.vx *= -1;
				}
				
				if (ball.y < ball.radius)
				{
					ball.y = ball.radius;
					ball.vy *= -1;
				}
				else if (ball.y > stage.stageHeight - ball.radius)
				{
					ball.y = stage.stageHeight - ball.radius;
					ball.vy *= -1;
				}
				ball.color = 0xffffff;
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}