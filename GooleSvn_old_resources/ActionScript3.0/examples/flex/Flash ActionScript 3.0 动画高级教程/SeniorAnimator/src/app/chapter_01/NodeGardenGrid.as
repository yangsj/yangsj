package app.chapter_01
{
	import code.chapter_01.CollisionGrid;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.resource.Ball;
	
	
	/**
	 * 说明：NodeGardenGrid
	 * @author victor
	 * 2012-4-8 下午10:40:38
	 */
	
	public class NodeGardenGrid extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var particles:Vector.<DisplayObject>
		private var numParticles:uint = 500;
		private var minDist:Number = 50;
		private var springAmount:Number = 0.001;
		private var grid:CollisionGrid;
		
		public function NodeGardenGrid()
		{
			super();this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			grid = new CollisionGrid(stage.stageWidth, stage.stageHeight, 50);
			particles = new Vector.<DisplayObject>();
			for (var i:int = 0; i < numParticles; i++)
			{
				var particle:Ball = new Ball(3);
				particle.x = Math.random() * stage.stageWidth;
				particle.y = Math.random() * stage.stageHeight;
				particle.vx = Math.random() * 6 - 3;
				particle.vy = Math.random() * 6 - 3;
				addChild(particle);
				particles.push(particle);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			graphics.clear();
			for (var i:uint = 0; i < numParticles; i++)
			{
				var ball:Ball = particles[i] as Ball;
				ball.update();
				if (ball.x < ball.radius)
				{
					ball.x = ball.radius;
				}
				else if (ball.x > stage.stageWidth - ball.radius)
				{
					ball.x = stage.stageWidth - ball.radius;
				}
				
				if (ball.y < ball.radius)
				{
					ball.y = ball.radius;
				}
				else if (ball.y > stage.stageHeight - ball.radius)
				{
					ball.y = stage.stageHeight - ball.radius;
				}
			}
			grid.check(particles);
			var checks:Vector.<DisplayObject> = grid.checks;
			var numChecks:int = checks.length;
			for (i = 0; i < numChecks; i += 2)
			{
				var partA:Ball = checks[i] as Ball;
				var partB:Ball = checks[i+1] as Ball;
				spring(partA, partB);
			}
		}
		
		private function spring(partA:Ball, partB:Ball):void
		{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if (dist < minDist)
			{
				graphics.lineStyle(1, 0xffffff, 1 - dist / minDist);
				graphics.moveTo(partA.x, partA.y);
				graphics.lineTo(partB.x, partB.y);
				var ax:Number = dx * springAmount;
				var ay:Number = dy * springAmount;
				
				partA.vx += ax;
				partA.vy += ay;
				partB.vx -= ax;
				partB.vy -= ay;
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}