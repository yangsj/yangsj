package victor.framework.utils
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-3
	 */
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}

		/**
		 * 对数组进行随机排序
		 * @param ary
		 */
		public static function randomSort( ary:* ):void
		{
			ary.sort( abc );
			function abc( a:*, b:* ):Number
			{
				return int( Math.random() * 3 ) - 1;
			}
		}
		
		public static function removeAll( ary:* ):void
		{
			if ( ary )
			{
				try
				{
					ary.length = 0;
				}
				catch ( e:Error )
				{
				}
			}
		}
		
		public static function cloneArray( ary:Array ):Array
		{
			var arr:Array = [];
			for each (var ay:* in ary )
			{
				arr.push( ay );
			}
			return arr;
		}
		

	}
}
