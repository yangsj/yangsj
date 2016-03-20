package app.chapter_06
{
	import code.SpriteBase;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	
	/**
	 * 说明：Euler
	 * @author victor
	 * 2012-8-6 下午10:50:37
	 */
	
	public class RK2 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _ball:Sprite;
		private var _position:Point;
		private var _velocity:Point;
		private var _gravity:Number = 32;
		private var _bounce:Number = -0.6;
		private var _oldTime:int;
		private var _pixelsPerFoot:Number = 10;
		
		public function RK2()
		{
			super();
		}
		
		override protected function initialization():void
		{
			if (_ball == null)
			{
				_ball = new Sprite();
				_ball.graphics.beginFill(0xff0000);
				_ball.graphics.drawCircle(0,0,20);
				_ball.graphics.endFill();
			}
			_ball.x = 50;
			_ball.y = 50;
			addChild(_ball);
			
			_velocity = new Point(10, 0);
			_position = new Point(_ball.x / _pixelsPerFoot, _ball.y / _pixelsPerFoot);
			
			_oldTime = getTimer();
			
			this.graphics.lineStyle(1);
			this.graphics.moveTo(_ball.x, _ball.y);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			var time:int = getTimer();
			var elapsed:Number = (time - _oldTime) * 0.001;
			_oldTime = getTimer();
			
			var accel1:Point = acceleration(_position, _velocity);
			
			var position2:Point = new Point();
			position2.x = _position.x + _velocity.x * elapsed;
			position2.y = _position.y + _velocity.y * elapsed;
			
			var velocity2:Point = new Point();
			velocity2.x = _velocity.x + _velocity.x * elapsed;
			velocity2.y = _velocity.y + _velocity.y * elapsed;
			
			var accel2:Point = acceleration(position2, velocity2);
			
			_position.x += (_velocity.x + velocity2.x) * 0.5 * elapsed;
			_position.y += (_velocity.y + velocity2.y) * 0.5 * elapsed;
			_velocity.x += (accel1.x + accel2.x) * 0.5 * elapsed;
			_velocity.y += (accel1.y + accel2.y) * 0.5 * elapsed;
			
			if (_position.y > (stage.stageHeight - 20) / _pixelsPerFoot)
			{
				_position.y = (stage.stageHeight - 20) / _pixelsPerFoot;
				_velocity.y *= _bounce;
			}
			if (_position.x > (stage.stageWidth - 20)  / _pixelsPerFoot)
			{
				_position.x = (stage.stageWidth - 20) / _pixelsPerFoot;
				_velocity.x *= _bounce;
			}
			if (_position.x < 20 / _pixelsPerFoot)
			{
				_position.x = 20 / _pixelsPerFoot;
				_velocity.x *= _bounce;
			}
			
			_ball.x = _position.x * _pixelsPerFoot;
			_ball.y = _position.y * _pixelsPerFoot;
			
			this.graphics.lineTo(_ball.x, _ball.y);
		}
		
		private function acceleration(p:Point, v:Point):Point
		{
			return new Point(0, _gravity);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}