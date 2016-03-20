package code.chapter_06
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * 说明：VerletStrck
	 * @author victor
	 * 2012-8-19 上午10:46:40
	 */
	
	public class VerletStick
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _pointA:VerletPoint;
		private var _pointB:VerletPoint;
		private var _length:Number;
		
		public function VerletStick(pointA:VerletPoint, pointB:VerletPoint, length:Number=-1)
		{
			_pointA = pointA;
			_pointB = pointB;
			if (length == -1)
			{
				var dx:Number = _pointA.x - _pointB.x;
				var dy:Number = _pointA.y - _pointB.y;
				_length = Math.sqrt(dx * dx + dy * dy);
			}
			else
			{
				_length = length;
			}
		}
		
		public function update():void
		{
			var dx:Number = _pointB.x - _pointA.x;
			var dy:Number = _pointB.y - _pointA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			var diff:Number = _length - dist;
			var offsetX:Number = (diff * dx / dist) * 0.5;
			var offsetY:Number = (diff * dy / dist) * 0.5;
			_pointA.x -= offsetX;
			_pointA.y -= offsetY;
			_pointB.x += offsetX;
			_pointB.y += offsetY;
		}
		
		public function render(g:Graphics):void
		{
			g.lineStyle(0);
			g.moveTo(_pointA.x, _pointA.y);
			g.lineTo(_pointB.x, _pointB.y);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}