package code.chapter_02
{
	import flash.display.Graphics;
	
	/**
	 * 说明：Vector2D
	 * @author victor
	 * 2012-4-10 上午12:27:32
	 */
	
	public class Vector2D
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _x:Number;
		private var _y:Number;
		
		public function Vector2D(x:Number=0, y:Number=0)
		{
			_x = x;
			_y = y;
		}
		
		public function draw(graphics:Graphics, color:uint=0):void
		{
			graphics.lineStyle(0, color);
			graphics.moveTo(0,0);
			graphics.lineTo(_x, _y);
		}
		
		public function clone():Vector2D
		{
			return new Vector2D(x, y);
		}
		
		public function zero():Vector2D
		{
			_x = 0;
			_y = 0;
			return this;
		}
		
		public function isZero():Boolean
		{
			return _x == 0 && _y == 0;
		}
		
		public function set length(value:Number):void
		{
			var a:Number = angle;
			_x = Math.cos(a) * value;
			_y = Math.sin(a) * value;
		}
		
		public function get length():Number
		{
			return Math.sqrt(lengthSQ);
		}
		
		public function get lengthSQ():Number
		{
			return _x * _x + _y * _y;
		}
		
		public function get angle():Number
		{
			return Math.atan2(_y, _x);
		}
		
		public function set angle(value:Number):void
		{
			var leng:Number = length;
			_x = Math.cos(value) * leng;
			_y = Math.sin(value) * leng;
		}
		
		public function normalize():Vector2D
		{
			if (length == 0)
			{
				_x = 1;
				return this;
			}
			var leng:Number = length;
			_x /= leng;
			_y /= leng;
			return this;
		}
		
		public function truncate(max:Number):Vector2D
		{
			length = Math.min(max, length);
			return this;
		}
		
		public function isNormalized():Boolean
		{
			return length == 1;
		}
		
		public function dotProd(v2:Vector2D):Number
		{
			return _x * v2.x + _y * v2.y;
		}
		
		public static function angleBetween(v1:Vector2D, v2:Vector2D):Number
		{
			if (!v1.isNormalized()) v1 = v2.clone().normalize();
			if (!v2.isNormalized()) v2 = v2.clone().normalize();
			return Math.acos(v1.dotProd(v2));
		}
		
		public function sign(v2:Vector2D):int
		{
			return perp.dotProd(v2);
		}
		
		public function get perp():Vector2D
		{
			return new Vector2D(-y, x);
		}
		
		public function dist(v2:Vector2D):Number
		{
			return Math.sqrt(distSQ(v2));
		}
		
		public function distSQ(v2:Vector2D):Number
		{
			var dx:Number = v2.x - x;
			var dy:Number = v2.y - y;
			return dx * dx + dy * dy;
		}
		
		public function add(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x + v2.x, _y + v2.y);
		}
		
		public function subtract(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x - v2.x, _y - v2.y);
		}
		
		public function multiply(value:Number):Vector2D
		{
			return new Vector2D(_x * value, _y * value);
		}
		
		public function divide(value:Number):Vector2D
		{
			return new Vector2D(_x / value, _y / value);
		}
		
		public function equals(v2:Vector2D):Boolean
		{
			return _x == v2.x && _y == v2.y;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function toString():String
		{
			return "[Vector2D(x:" + x + ", y:" + y + ")]";
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}