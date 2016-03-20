package app.chapter_01
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.resource.Ball;
	
	
	/**
	 * 说明：NodeGardenLines
	 * @author victor
	 * 2012-4-8 下午09:58:34
	 */
	
	public class NodeGardenLines extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var particles:Vector.<Ball>;
		private var numParticles:uint = 300;
		private var minDist:Number = 100;
		private var springAmount:Number = 0.001;
		
		public function NodeGardenLines()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			particles = new Vector.<Ball>();
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
			for (i = 0; i < numParticles - 1; i++)
			{
				var partA:Ball = particles[i];
				for (var j:uint = i + 1; j < numParticles; j++)
				{
					var partB:Ball = particles[j];
					spring(partA, partB);
				}
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