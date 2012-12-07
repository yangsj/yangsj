package utils
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	/**
	 * @author Administrator
	 */
	public class BitmapUtils
	{
		public static function draw(target : DisplayObject, bmd : BitmapData = null, transparent : Boolean = true, bgColor : uint = 0, bounding : uint = 0, colorTransform : ColorTransform = null, blendMode : String = null, offset : Point = null) : BitmapData
		{
			var rect : Rectangle = target.getBounds(target);
			if (rect.width == 0 || rect.height == 0)
			{
				throw('Invaild size');
			}
			offset ||= new Point();
			bmd ||= new BitmapData(target.width + bounding * 2, target.height + bounding * 2, transparent, bgColor);
			bmd.draw(target, new Matrix(target.scaleX, 0, 0, target.scaleY, -rect.left * target.scaleX - offset.x + bounding, -rect.top * target.scaleY - offset.y + bounding), colorTransform, blendMode);
			return bmd;
		}

		public static function hitTest(a : DisplayObject, b : DisplayObject, bmd1 : BitmapData = null, testInclded : Boolean = true) : Boolean
		{
			var bound1 : Rectangle = a.getBounds(a);
			var bound2 : Rectangle = b.getBounds(a);
			if (!testInclded)
			{
				if (bound1.containsRect(bound2) || bound2.containsRect(bound1))
					return true;
			}
			var intersect : Rectangle = bound1.intersection(bound2);
			if (intersect.width < 1 || intersect.height < 1)
				return false;
			bmd1 ||= BitmapUtils.draw(a, null, false, 0, 0, new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));

			var bmd2 : BitmapData = new BitmapData(intersect.width, intersect.height, true, 0);
			bmd2.copyPixels(bmd1, new Rectangle(intersect.x - bound1.x, intersect.y - bound1.y, intersect.width, intersect.height), new Point());
			BitmapUtils.draw(b, bmd2, false, 0, 0, new ColorTransform(1, 1, 1, 1, -255, 255, -255, 255), BlendMode.ADD, new Point(intersect.x - bound2.x, intersect.y - bound2.y));
			var result : Boolean = bmd2.getVector(bmd2.rect).indexOf(0xffffff00) != -1;
			bmd2.dispose();
			return result;
		}
		
		public static function cacheAsBitmap(dis:DisplayObject):void
		{
			if (dis)
			{
				dis.cacheAsBitmap = true;
				dis.cacheAsBitmapMatrix = new Matrix();
			}
		}
	}
}
