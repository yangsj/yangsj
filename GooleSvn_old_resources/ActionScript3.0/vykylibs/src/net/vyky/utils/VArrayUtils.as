package net.vyky.utils
{
	
	/**
	 * 说明：ArrayUrils
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-6
	 */
	
	public class VArrayUtils
	{
		
		
		public function VArrayUtils()
		{
		}
		
		public static function removeValueFromArray(arr:Array, value:Object):void
		{
			var len:uint = arr.length;
			for(var i:Number = len; i > -1; i--)
			{
				if(arr[i] === value)
				{
					arr.splice(i, 1);
				}
			}					
		}		
		
		public static function arrayContainsValue(arr:Array, value:Object):Boolean
		{
			return (arr.indexOf(value) != -1);
		}
		
		public static function createUniqueCopy(a:Array):Array
		{
			var newArray:Array = new Array();
			var len:Number = a.length;
			var item:Object;
			for (var i:uint = 0; i < len; ++i)
			{
				item = a[i];
				if(VArrayUtils.arrayContainsValue(newArray, item))
				{
					continue;
				}
				newArray.push(item);
			}
			
			return newArray;
		}	
		
		public static function arraysAreEqual(arr1:Array, arr2:Array):Boolean
		{
			if(arr1.length != arr2.length)
			{
				return false;
			}
			var len:Number = arr1.length;
			for(var i:Number = 0; i < len; i++)
			{
				if(arr1[i] !== arr2[i])
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		 * 将指定的一个数组内容随机打乱
		 * @param array 指定需要打乱的数组，直接改变原数组
		 */
		public static function randomSortOn(array:Array):void
		{
			var r:int = int(Math.random() * array.length) + 3;
			for(var i:int = 0; i <= r; i++)
			{
				array.unshift();
				array.sort(randomSortOnFunction);
			}
		}
		
		private static function randomSortOnFunction(a:*, b:*):int
		{
			return int(Math.random() * 3) - 1; // -1,0,1
		}
		
	}
	
}