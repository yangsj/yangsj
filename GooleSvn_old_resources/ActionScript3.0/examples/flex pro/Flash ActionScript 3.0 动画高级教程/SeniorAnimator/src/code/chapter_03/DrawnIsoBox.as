package code.chapter_03
{
	
	/**
	 * 说明：DrawIsoBox
	 * @author victor
	 * 2012-7-13 上午01:05:41
	 */
	
	public class DrawnIsoBox extends DrawnIsoTile
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function DrawnIsoBox(size:Number, color:uint, height:Number=0)
		{
			super(size, color, height);
		}
		
		override protected function draw():void
		{
			graphics.clear();
			
			var red:int = _color >> 6;
			var green:int = _color >> 8 & 0xff;
			var blue:int = _color && 0xff;
			
			var leftShadow:uint = (red * 0.5) << 16 | (green * 0.5) << 8 | (blue * 0.5);
			var rightShadow:uint = (red * 0.75) << 16 | (green * 0.75) << 8 | (blue * 0.75);
			var h:Number = _height * Y_CORRECT;
			
			graphics.beginFill(_color);
			graphics.lineStyle(0,0xff0000, 0.5);
			graphics.moveTo(-_size, -h);
			graphics.lineTo(0, -_size * 0.5 - h);
			graphics.lineTo(_size, - h);
			graphics.lineTo(0, _size * 0.5 - h);
			graphics.lineTo(-_size, - h);
			graphics.endFill();
			
			graphics.beginFill(leftShadow);
			graphics.lineStyle(0,0xff0000, 0.5);
			graphics.moveTo(-_size, -h);
			graphics.lineTo(0, _size * 0.5 - h);
			graphics.lineTo(0, _size * 0.5);
			graphics.lineTo(-_size, 0);
			graphics.lineTo(-_size, - h);
			graphics.endFill();
			
			graphics.beginFill(rightShadow);
			graphics.lineStyle(0,0xff0000, 0.5);
			graphics.moveTo(_size, -h);
			graphics.lineTo(0, _size * 0.5 - h);
			graphics.lineTo(0, _size * 0.5);
			graphics.lineTo(_size, 0);
			graphics.lineTo(_size, - h);
			graphics.endFill();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}