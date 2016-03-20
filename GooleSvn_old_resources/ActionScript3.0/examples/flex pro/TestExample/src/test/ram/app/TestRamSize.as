package test.ram.app
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import test.ram.code.Ball;
	
	
	/**
	 * 说明：TestRamSize
	 * @author victor
	 * 2012-8-5 上午12:41:08
	 */
	
	public class TestRamSize extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
//		private var ball:Ball;
		
		public function TestRamSize()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			this.stage.addEventListener(MouseEvent.CLICK, onStageClickHandler);
			
			var timer:Timer = new Timer(100, 10000);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completed);
			timer.start();
//			for (var i:int = 0; i < 10000; i++)
//			{
//				stage.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
//			}
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			stage.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function completed(e:TimerEvent):void
		{
			var timer:Timer = e.target as Timer;
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completed);
			timer.start();
		}
		
		private function onStageClickHandler(e:MouseEvent):void
		{
			while (this.numChildren > 0) this.removeChildAt(0);
			
//			if (ball == null)
//			{
//				ball = new Ball();
//				this.addChild(ball);
//				ball.mouseChildren = ball.mouseEnabled = false;
//			}
			var ball:Ball = new Ball();
			this.addChild(ball);
			ball.mouseChildren = ball.mouseEnabled = false;
			
//			ball.drawRamdonColorBall();
			
			ball.x = e.localX;
			ball.y = e.localY;
			
			ball = null;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}