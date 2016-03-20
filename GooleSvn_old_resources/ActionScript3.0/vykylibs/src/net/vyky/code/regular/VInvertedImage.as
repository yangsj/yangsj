package net.vyky.code.regular
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * 说明：InvertedImage 显示对象倒影
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-5
	 */

	public class VInvertedImage
	{

		/////////////////////////////////static ////////////////////////////



		///////////////////////////////// vars /////////////////////////////////



		public function VInvertedImage()
		{
		}

		/////////////////////////////////////////public /////////////////////////////////

		/**
		 * 注意：注册点须是左上角
		 * @param p_source
		 * 
		 */
		public static function createRef(p_source:DisplayObject):void
		{
			//对源显示对象做上下反转处理
			var bd:BitmapData=new BitmapData(p_source.width, p_source.height, true, 0);
			var mtx:Matrix=new Matrix();
			mtx.d=-1;
			mtx.ty=bd.height;
			bd.draw(p_source, mtx);

			//生成一个渐变遮罩
			var width:int=bd.width;
			var height:int=bd.height;
			mtx=new Matrix();
			mtx.createGradientBox(width, height, 0.5 * Math.PI);
			var shape:Shape=new Shape();
			shape.graphics.beginGradientFill(GradientType.LINEAR, [0, 0], [0.9, 0], [0, 0xFF], mtx);
			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
			var mask_bd:BitmapData=new BitmapData(width, height, true, 0);
			mask_bd.draw(shape);
			
			//生成最终效果;
			bd.copyPixels(bd, bd.rect, new Point(0, 0), mask_bd, new Point(0, 0), false);
			//将倒影位图放在源显示对象下面
			var ref:Bitmap=new Bitmap();
			ref.y=p_source.height;
			ref.bitmapData=bd;
			p_source.parent.addChild(ref);

		}

		/////////////////////////////////////////private ////////////////////////////////



		/////////////////////////////////////////events//////////////////////////////////


	}

}
