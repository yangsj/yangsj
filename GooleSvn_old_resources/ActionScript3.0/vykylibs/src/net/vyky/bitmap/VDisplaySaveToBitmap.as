package net.vyky.bitmap
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/** 
	 * 说明：
	 * @author 杨胜金
	 * 2011-10-28 下午03:34:20
	 */
	public class VDisplaySaveToBitmap
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function VDisplaySaveToBitmap()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 将图片保存到本地
		 * @param $target 指定要保存为图片的显示容器
		 * @param $name 指定图片的名称
		 * 
		 */
		public static function saveToLocal($target:DisplayObjectContainer, $name:String):void
		{
			var rects:Rectangle = $target.getBounds($target);
			var i:int = 0;
			var disTemp:DisplayObject;
			var leng:int = $target.numChildren;
			
			for (i; i < leng; i++)
			{
				disTemp = $target.getChildAt(i);
				disTemp.x = disTemp.x - rects.x;
				disTemp.y = disTemp.y - rects.y;
			}
				
			var file:FileReference = new FileReference();
			var bitmapData:BitmapData = new BitmapData($target.width, $target.height);
			bitmapData.draw($target,new Matrix());
			var jpg:JPGEncoder = new JPGEncoder();
			var ba:ByteArray = jpg.encode(bitmapData);
			var url:String = $name + ".jpg";
			file.save(ba,url);
			
			for (i = 0; i < leng; i++)
			{
				disTemp = $target.getChildAt(i);
				disTemp.x = disTemp.x + rects.x;
				disTemp.y = disTemp.y + rects.y;
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////

		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}