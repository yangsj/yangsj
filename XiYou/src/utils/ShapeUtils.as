package utils
{

	import flash.geom.Rectangle;
	import flash.display.Shape;


	/**
	 * @author Administrator
	 */
	public class ShapeUtils
	{
		public static function drawRect(rect : Rectangle, color : uint = NaN) : Shape
		{
			var shape : Shape = new Shape();
			shape.graphics.lineStyle(1, isNaN(color) ? 0xffffff * Math.random() : color);
			shape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			return shape;
		}
	}
}
