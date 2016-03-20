package code.chapter_03
{
	
	/**
	 * 说明：DrawnIsoTile
	 * @author victor
	 * 2012-7-13 上午12:14:19
	 */
	
	public class DrawnIsoTile extends IsoObject
	{
		
		////////////////// vars /////////////////////////////////
		
		protected var _height:Number;
		protected var _color:uint;
		
		public function DrawnIsoTile(size:Number, color:uint, height:Number = 0)
		{
			super(size);
			_color = color;
			_height = height;
			draw();
		}
		
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(_color);
			graphics.lineStyle(0, 0xff0000, 0.5);
			graphics.moveTo(-size, 0);
			graphics.lineTo(0, - size * 0.5);
			graphics.lineTo(size, 0);
			graphics.lineTo(0, size * 0.5);
			graphics.lineTo(-size, 0);
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
			draw();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			draw();
		}
		
		public function get colot():uint
		{
			return _color;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}