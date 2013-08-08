package app.utils
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
			function abc( a:int, b:int ):Number
			{
				return int( Math.random() * 3 ) - 1;
			}
		}
		
		public static function split( string:String, delim:* ):Array
		{
			return string.split( delim );
		}

	}
}
