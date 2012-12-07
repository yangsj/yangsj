package utils
{
	import flash.geom.Point;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Vector3D;

	/**
	 * Sprite工具类
	 * @author Chenzhe
	 */
	public class SpriteUtils
	{
		/**
		 * 将目标沿着向量移动一段距离
		 * @param target 目标
		 * @param vec 向量，即移动方向
		 * @param distance 移动距离
		 */
		public static function translate(target : DisplayObject, vec : Vector3D, distance : Number) : void
		{
			vec.normalize();
			vec.scaleBy(distance);
			target.x += vec.x;
			target.y += vec.y;
			if (vec.z != 0)
				target.z += vec.z;
		}

		public static function forEachChild(container : DisplayObjectContainer, func : Function) : void
		{
			for (var i : int = 0; i < container.numChildren; i++)
			{
				func(container.getChildAt(i));
			}
		}

		/**
		 * 安全地移除一个显示对象。即：仅当对象在显示列表中才将其移除
		 * @param target 要移除的显示对象
		 */
		public static function safeRemove(target : DisplayObject) : void
		{
			if (target.parent != null)
				target.parent.removeChild(target);
		}

		public static function children(container : DisplayObjectContainer) : Array
		{
			var arr : Array = [];
			for (var i : int = 0; i < container.numChildren; i++) {
				arr.push(container.getChildAt(i));
			}
			return arr;
		}

		public static function position(target : Sprite) : Point
		{
			return new Point(target.x, target.y);
		}

		public static function zSort(layer : Sprite) : void
		{
			var all : Array = children(layer);
			all.sortOn('y', Array.NUMERIC);
			for (var i : * in all) {
				var child : * = all[i];
				layer.setChildIndex(child, i);
			}
		}
	}
}
