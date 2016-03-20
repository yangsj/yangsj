package net.vyky.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * 说明：Hit
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-2-17
	 */
	
	public class VHitTestUtils
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		
		
		/**
		 * 
		 * 像素级碰撞检测（不规则形状）
		 * @param obj1 对象1
		 * @param obj2 对象2
		 * @param alphaThreshold 按 Alpha (0<= Alpha <=1) 的值进行检测, 默认值为1。
		 * @return Boolean
		 */
		public static function pixelsHitTest(obj1:*, obj2:*, alphaThreshold:Number = 0):Boolean
		{
			alphaThreshold = alphaThreshold < 0 ? 0 : alphaThreshold > 1 ? 1 : alphaThreshold;
			var bitmapD:BitmapData = new BitmapData(obj1.width,obj1.height,true,0);
			bitmapD.draw(obj1);
			var bitmapD1:BitmapData = new BitmapData(obj2.width,obj2.height,true,0);
			bitmapD1.draw(obj2);
			var tempAlhpa:Number = uint(255 * alphaThreshold);
			if (bitmapD.hitTest(new Point(obj1.x, obj1.y), tempAlhpa, bitmapD1, new Point(obj2.x, obj2.y), tempAlhpa))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 
		 * 两个对象之间的碰撞（矩形碰撞）
		 * @param obj1 对象1
		 * @param obj2 对象2
		 * @return Boolean
		 */
		public static function hitTestObject(obj1:DisplayObject, obj2:DisplayObject):Boolean
		{
			if (obj1.hitTestObject(obj2))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}