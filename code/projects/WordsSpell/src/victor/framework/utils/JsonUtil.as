package victor.framework.utils
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class JsonUtil
	{
		
		/**
		 * 接受 JSON 格式的字符串并返回表示该值的 ActionScript 对象。
		 * @param text
		 * @param reviver
		 * @return 
		 */
		public static function parse(text:String, reviver:Function=null):Object
		{
			return JSON.parse( text, reviver );
		}
		
		/**
		 * 返回 JSON 格式的字符串，用于表示 ActionScript 值
		 * @param value
		 * @param replacer
		 * @param space
		 * @return 
		 */
		public static function stringify(value:Object, replacer:*=null, space:*=null):String
		{
			return JSON.stringify( value, replacer, space );
		}
		
	}
}