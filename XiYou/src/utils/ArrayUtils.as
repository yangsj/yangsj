package utils
{
	/**
	 * 数组工具类
	 * @author Chenzhe
	 */
	public class ArrayUtils
	{
		/**
		 * 从数组里删除一个对象，如果对象不在数组里不会做任何改变
		 * @param arr 数组
		 * @param target 要删除的对象
		 */
		public static function remove(arr : Array, target : *) : void
		{
			var i : int = arr.indexOf(target);
			if (i != -1)
				arr.splice(i, 1);
		}

		public static function selectOne(arr : Array, f : Function) : *
		{
			for each (var element : * in arr)
			{
				if (f(element))
					return element;
			}
		}

		public static function last(arr : Array) : *
		{
			return arr[arr.length - 1];
		}

		/**
		 * 获取数组里一个随机元素
		 * @param arr 数组
		 * @return 随机元素
		 */
		public static function random(arr : Array) : *
		{
			return arr[int(Math.random() * arr.length)];
		}

		public static function uniquePush(arr : Array, target : *) : void
		{
			if (arr.indexOf(target) == -1)
				arr.push(target);
		}

		public static function removeNull(arr : Array) : Array
		{
			return arr.filter(function(a : *, ...rest) : Boolean
			{
				return a != null;
			});
		}

		// // // ////////////////////////////////////////////////////////////////////
		/**
		 * 移除指定数据的所有元素
		 */
		public static function removeAll(array : *) : void
		{
			if (array && (array is Array || array is Vector.<*>))
			{
				while (array.length > 0)
				{
					array.pop();
				}
			}
			array = null;
		}

		/**
		 * 创建一个和指定数组相同的新的数组
		 * @param a 复制的模本 数组
		 * @return 新的 Array
		 */
		public static function createUniqueCopy(a : Array) : Array
		{
			var newArray : Array = [];
			var len : Number = a.length;
			var item : Object;
			for (var i : uint = 0; i < len; ++i)
			{
				item = a[i];
				newArray.push(item);
			}
			return newArray;
		}

		/**
		 * 将指定的一个数组内容随机打乱
		 * @param array 指定需要打乱的数组，直接改变原数组
		 */
		public static function randomSortOn(array : Array) : void
		{
			var r : int = int(Math.random() * array.length) + 3;
			for (var i : int = 0; i <= r; i++)
			{
				array.unshift();
				array.sort(randomSortOnFunction);
			}
		}

		private static function randomSortOnFunction(a : *, b : *) : int
		{
			return int(Math.random() * 3) - 1;
			// -1,0,1
		}
	}
}
