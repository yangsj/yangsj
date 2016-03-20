package ui.resource
{
	import flash.display.Sprite;
	
	
	/**
	 * 说明：Ball
	 * @author victor
	 * 2012-4-8 下午12:55:38
	 */
	
	public class Ball extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _color:uint;
		private var _radius:Number;
		private var _vx:Number = 1;
		private var _vy:Number = 1;
		
		public function Ball($radius:Number, $color:uint=0xffffff)
		{
			_radius = $radius;
			_color = $color;
			draw();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		public function update():void
		{
			x += _vx;
			y += _vy;
		}
		
		////////////////// private ////////////////////////////////
		
		private function draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(0);
			this.graphics.beginFill(_color, 0.5);
			this.graphics.drawCircle(0,0,_radius);
			this.graphics.endFill();
			this.graphics.drawCircle(0,0,1);
		}
		
		////////////////// events//////////////////////////////////
		
		
		
		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
			draw();
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
			draw();
		}

		public function get vx():Number
		{
			return _vx;
		}

		public function set vx(value:Number):void
		{
			_vx = value;
		}

		public function get vy():Number
		{
			return _vy;
		}

		public function set vy(value:Number):void
		{
			_vy = value;
		}


	}
}