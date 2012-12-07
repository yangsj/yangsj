package test
{

	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.display.Bitmap;
	import utils.BitmapUtils;
	import flash.display.MovieClip;


	/**
	 * @author Administrator
	 */
	public class BitmapHittest extends MovieClip
	{
		public function BitmapHittest()
		{
			var a : Sprite = this['a'];
			var b : Sprite = this['b'];
			b.scaleX = b.scaleY = 2;
			var bound1 : Rectangle = a.getBounds(this);
			var bound2 : Rectangle = b.getBounds(this);
			var intersect : Rectangle = bound1.intersection(bound2);
			var shape1 : Shape = new Shape();
			shape1.graphics.lineStyle(1, 0x006600);
			shape1.graphics.drawRect(bound1.x, bound1.y, bound1.width, bound1.height);
			addChild(shape1);
			var shape2 : Shape = new Shape();
			shape2.graphics.lineStyle(1, 0x9933cc);
			shape2.graphics.drawRect(bound2.x, bound2.y, bound2.width, bound2.height);
			addChild(shape2);
			var shape3 : Shape = new Shape();
			shape3.graphics.lineStyle(1, 0xff6600);
			shape3.graphics.drawRect(intersect.x, intersect.y, intersect.width, intersect.height);
			addChild(shape3);

			var bmd1 : BitmapData = BitmapUtils.draw(a, null, false, 0, 0, new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));

			var bm1 : Bitmap = new Bitmap(bmd1);
			bm1.x = -300;

			var bmd2 : BitmapData = new BitmapData(intersect.width, intersect.height, true, 0);
			bmd2.copyPixels(bmd1, new Rectangle(intersect.x - bound1.x, intersect.y - bound1.y, intersect.width, intersect.height), new Point());
			BitmapUtils.draw(b, bmd2, false, 0, 0, new ColorTransform(1, 1, 1, 1, -255, 255, -255, 255), BlendMode.ADD, new Point(intersect.x - bound2.x, intersect.y - bound2.y));
			trace('intersect: ' + (intersect));
			trace('0xff000000: ' + (0xffffff00));
			trace('intersect color' + (bmd2.getVector(bmd2.rect).indexOf(0xffffff00)));
			trace('hitTest: ' + (BitmapUtils.hitTest(a, b, bmd1)));
			//bmd2.draw(b, new Matrix(b.scaleX, 0, 0, b.scaleY, -rect.left * b.scaleX, -rect.top * target.scaleY + bounding), null, blendMode, intersect);
			var bm2 : Bitmap = new Bitmap(bmd2); //BitmapUtils.draw(b, false, 0, 0, new ColorTransform(1, 1, 1, 1, -255, 255, -255, 255))
			bm2.x = -100;
			addChild(bm1);
			addChild(bm2);
		}
	}
}
