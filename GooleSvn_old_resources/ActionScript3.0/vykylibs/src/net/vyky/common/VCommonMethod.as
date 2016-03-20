package net.vyky.common
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/** 
	 * 说明：通用常用方法集合
	 * @author Victor
	 * 2012-1-11 下午06:03:47
	 */
	public class VCommonMethod
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function VCommonMethod()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 获取实际字符串长度（即中文为2，英文为1）
		 * @param str 需要判断的实际字符串
		 * @return 实际字符串长度
		 * 
		 */
		public static function getRealLength(str:String):uint 
		{
			var len:uint = str.replace(/[^\x00-\xff]/mg, "00").length;
			return len;
		}
		
		/**
		 * 指定对象添加到指定容器剧中显示
		 * @param $parent 指定容器
		 * @param $child 指定需要显示到指定容器中的显示对象
		 * 
		 */
		public static function setChildAddCenter($parent:DisplayObjectContainer, $child:DisplayObject):void
		{
			var rect1:Rectangle = $parent.getBounds($parent);
			var rect2:Rectangle = $child.getBounds($child);
			var ratioX:Number = $child.scaleX;
			var ratioY:Number = $child.scaleY;
			$child.x = rect1.x + (rect1.width - $child.width) * 0.5 - rect2.x * ratioX;
			$child.y = rect1.y + (rect1.height- $child.height)* 0.5 - rect2.y * ratioY;
			$parent.addChild($child);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}