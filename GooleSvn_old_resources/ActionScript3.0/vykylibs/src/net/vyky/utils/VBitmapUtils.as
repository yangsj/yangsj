package net.vyky.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	/**
	 * 说明：BitmapUtils
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-7-9
	 */
	
	public class VBitmapUtils
	{
		
		
		public function VBitmapUtils()
		{
		}
		
		public static function drawAsBitmap($source:DisplayObject, 
											$imageAlpha:Number = 1,
											$smoothing:Boolean = true):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData($source.width, $source.height, true, 0);
			bitmapData.draw($source, null, new ColorTransform(1,1,1,$imageAlpha) , null, null, $smoothing);
			var bitmap:Bitmap = new Bitmap(bitmapData, "auto", $smoothing);
			
			return bitmap;
		}
		
		public static function cacheAsBitmap($source:DisplayObject):void
		{
			
		}
		
	}
	
}