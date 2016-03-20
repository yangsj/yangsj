package app.chapter_01
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getTimer;
	
	import ui.resource.Ball;
	
	/**
	 * 说明：GridCollision
	 * @author victor
	 * 2012-4-8 下午01:03:05
	 */
	
	public class GridCollision extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private const GRID_SIZE:Number = 50;
		private const RADIUS:Number = 25;
		
		private var _balls:Array;
		private var _grid:Array;
		private var _numBalls:int = 1000;
		private var _numChecks:int = 0;
		
		public function GridCollision()
		{	
			
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		public function initialization():void
		{
			var time:Number = getTimer();
			makeBalls();
			makeGrid();
			drawGrid();
			assignBallsToGrid();
			checkGrid();
//			baseCkeck();
			trace(_numChecks);
			trace(getTimer() - time);
		}
		
		private function makeBalls():void
		{
			_balls = new Array();
			for (var i:int = 0; i < _numBalls; i++)
			{
				var ball:Ball = new Ball(Math.random() * (RADIUS-5) + 5);
				ball.x = Math.random() * this.stage.stageWidth;
				ball.y = Math.random() * this.stage.stageHeight;
				addChild(ball);
				_balls.push(ball);
			}
		}
		
		private function makeGrid():void
		{
			_grid = new Array();
			for (var i:int = 0; i < this.stage.stageWidth / GRID_SIZE; i++)
			{
				_grid[i] = new Array();
				for (var j:int = 0; j < this.stage.stageHeight / GRID_SIZE; j++)
				{
					_grid[i][j] = new Array();
				}
			}
		}
		
		private function drawGrid():void
		{
			graphics.lineStyle(0, 0.5);
			var i:int;
			for (i = 0; i < stage.stageWidth; i += GRID_SIZE)
			{
				graphics.moveTo(i, 0);
				graphics.lineTo(i, stage.stageHeight);
			}
			for (i = 0; i < stage.stageWidth; i += GRID_SIZE)
			{
				graphics.moveTo(0, i);
				graphics.lineTo(stage.stageWidth, i);
			}
		}
		
		private function assignBallsToGrid():void
		{
			for (var i:int = 0; i < _numBalls; i++)
			{
				var ball:Ball = _balls[i] as Ball;
				var xpos:Number = int(ball.x / GRID_SIZE);
				var ypos:Number = int(ball.y / GRID_SIZE);
				_grid[xpos][ypos].push(ball);
			}
		}
		
		private function checkGrid():void
		{
			for (var i:int = 0; i < _grid.length; i++)
			{
				var arr:Array = _grid[i] as Array;
				for (var j:int = 0; j < arr.length; j++)
				{
					checkOneCell(i, j);
					checkTwoCell(i, j, i + 1, j);
					checkTwoCell(i, j, i - 1, j + 1);
					checkTwoCell(i, j, i, j + 1);
					checkTwoCell(i, j, i + 1, j + 1);
				}
			}
		}
		
		private function checkOneCell(x:int, y:int):void
		{
			var cell:Array = _grid[x][y] as Array;
			var leng:int = cell.length;
			for (var i:int = 0; i < leng - 1; i++)
			{
				var ballA:Ball = cell[i] as Ball;
				for (var j:int = i+1; j < leng; j++)
				{
					var ballB:Ball = cell[j] as Ball;
					checkCollision(ballA, ballB);
				}
			}
		}
		
		private function checkTwoCell(x1:int, y1:int, x2:int, y2:int):void
		{
			if (x2 < 0) return ;
			if (x2 >= _grid.length) return ;
			if (y2 >= _grid[x2].length) return ;
			var cell0:Array = _grid[x1][y1] as Array;
			var cell1:Array = _grid[x2][y2] as Array;
			for (var i:int = 0; i < cell0.length; i++)
			{
				var ballA:Ball = cell0[i] as Ball;
				for (var j:int = 0; j < cell1.length; j++)
				{
					var ballB:Ball = cell1[j] as Ball;
					checkCollision(ballA, ballB);
				}
			}
		} 
		
		private function baseCkeck():void
		{
			var leng:int = _balls.length;
			for (var i:int = 0; i < leng - 1; i++)
			{
				var ballA:Ball = _balls[i] as Ball;
				for (var j:int = i + 1; j < leng; j++)
				{
					var ballB:Ball = _balls[j] as Ball;
					checkCollision(ballA, ballB);
				}
			}
		}
		
		private function checkCollision(ballA:Ball, ballB:Ball):void
		{
			_numChecks++;
			var dx:Number = ballB.x - ballA.x;
			var dy:Number = ballB.y - ballA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if (dist < ballA.radius + ballB.radius)
			{
				ballA.color = 0xff0000;
				ballB.color = 0xff0000;
			}
		}
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}