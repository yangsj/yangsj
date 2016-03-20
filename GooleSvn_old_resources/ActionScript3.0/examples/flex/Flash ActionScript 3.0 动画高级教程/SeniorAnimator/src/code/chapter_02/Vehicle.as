package code.chapter_02
{
	import flash.display.Sprite;
	
	
	/**
	 * 说明：Vehicle
	 * @author victor
	 * 2012-4-10 上午12:52:51
	 */
	
	public class Vehicle extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		public static const WRAP:String = "wrap";
		public static const BOUNCE:String = "bounce";
		
		protected var _edgeBehavior:String = WRAP;
		protected var _mass:Number = 1;
		protected var _maxSpeed:Number = 10;
		protected var _position:Vector2D;
		protected var _velocity:Vector2D;
		
		public function Vehicle()
		{
			super();
			_position = new Vector2D();
			_velocity = new Vector2D();
			draw();
		}
		
		protected function draw():void
		{
			graphics.clear();
			graphics.lineStyle(0, 0xff0000);
			graphics.moveTo(10, 0);
			graphics.lineTo(-10, 5);
			graphics.lineTo(-10, -5);
			graphics.lineTo(10, 0);
		}
		
		public function update():void
		{
			_velocity.truncate(_maxSpeed);
			_position = _position.add(_velocity);
			if (_edgeBehavior == WRAP)
			{
				wrap();
			}
			else if (_edgeBehavior == BOUNCE)
			{
				bounce();
			}
			
			x = position.x;
			y = position.y;
			rotation = _velocity.angle * 180 / Math.PI;
		}
		
		private function bounce():void
		{
			if (stage != null)
			{
				if (position.x > stage.stageWidth)
				{
					position.x = stage.stageWidth;
					velocity.x *= -1;
				}
				else if (position.x < 0)
				{
					position.x = 0;
					velocity.x *= -1;
				}
				if (position.y > stage.stageHeight)
				{
					position.y = stage.stageHeight;
					velocity.y *= -1;
				}
				else if (position.y < 0)
				{
					position.y = 0;
					velocity.y *= -1;
				}
			}
		}
		
		private function wrap():void
		{
			if (stage != null)
			{
				if (position.x > stage.stageWidth) position.x = 0;
				if (position.x < 0) position.x = stage.stageWidth;
				if (position.y > stage.stageHeight) position.y = 0;
				if (position.y < 0) position.y = stage.stageHeight;
			}
		}

		public function get edgeBehavior():String
		{
			return _edgeBehavior;
		}

		public function set edgeBehavior(value:String):void
		{
			_edgeBehavior = value;
		}

		public function get mass():Number
		{
			return _mass;
		}

		public function set mass(value:Number):void
		{
			_mass = value;
		}

		public function get maxSpeed():Number
		{
			return _maxSpeed;
		}

		public function set maxSpeed(value:Number):void
		{
			_maxSpeed = value;
		}

		public function get position():Vector2D
		{
			return _position;
		}

		public function set position(value:Vector2D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}

		public function get velocity():Vector2D
		{
			return _velocity;
		}

		public function set velocity(value:Vector2D):void
		{
			_velocity = value;
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;
			_position.x = value;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
			_position.y = value;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}