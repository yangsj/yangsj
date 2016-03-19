package 
{

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import com.greensock.events.TweenEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class Main extends MovieClip
	{
		
		private const start_ball_x:int = 275;
		private const start_ball_y:int = 200;
		
		
		//private var xTxt:TextField;
		//private var yTxt:TextField;
		//private var ball:MovieClip;
		private var pointAry:Array;
		private var index:int = 0;
		private var timer:Timer;
		
		public function Main()
		{
			startBtn.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			index = 0;
			ball.x = start_ball_x;
			ball.y = start_ball_y;
			pointAry = [];
			trace("leng:", leng);
			var tyy:int = 0;
			for (var i:int = 1; i <= leng; i++)
			{
				var tx:Number = distancex > 0 ? i : -i;
				tx = i == leng ? distancex : tx;
				var ty:int = g * tx * tx;
				if (ty != tyy)
				{
					tyy = ty;
					pointAry.push({x:start_ball_x + tx, y:start_ball_y + ty});
					trace("x:", start_ball_x + tx, "y:", start_ball_y + ty);
				}
				
			}
			this.graphics.clear();
			this.graphics.lineStyle(1);
			this.graphics.moveTo(ball.x, ball.y);
			//this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			timer = new Timer(1);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			trace(endx, endy,"==========================================================");
			//if (pointAry.length)
//				TweenMax.to(ball, 1, {bezier:pointAry,orientToBezier:true,onUpdateListener:updateHandler});
//			else
//				TweenMax.to(ball, 0.5, {x:endx, y:endy});
		}
		
		private function updateHandler(e:TweenEvent):void
		{
			trace(ball.x, ball.y, ball.rotation);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var obj:Object = pointAry[index];
			ball.x = obj.x;
			ball.y = obj.y;
			index++;
			if (index == pointAry.length || (ball.x == endx && ball.y == endy))
			{
				this.graphics.endFill();
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else
			{
				this.graphics.lineTo(ball.x, ball.y);
			}
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			var obj:Object = pointAry[index];
			ball.x = obj.x;
			ball.y = obj.y;
			index++;
			trace(timer.delay, timer.currentCount);
			if (index == pointAry.length || (ball.x == endx && ball.y == endy))
			{
				this.graphics.endFill();
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				timer = null;
			}
			else
			{
				this.graphics.lineTo(ball.x, ball.y);
			}
		}
		
		// 结束x
		private function get endx():Number
		{
			return Number(xTxt.text);
		}
		// 结束y
		private function get endy():Number
		{
			return Number(yTxt.text);
		}
		// 加速度g
		private function get g():Number
		{
			return Number(distancey / (distancex * distancex));
		}
		// x轴距离
		private function get distancex():Number
		{
			return (endx - start_ball_x);
		}
		// y轴距离
		private function get distancey():Number
		{
			return (endy - start_ball_y);
		}
		// 结束点和起始点x轴距离像数点数
		private function get leng():int
		{
			return Math.abs(distancex);
		}
		
	}

}