package victor.framework.utils
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-4
	 */
	public class MathUtil
	{
		public function MathUtil()
		{
		}
		
		public static function range(value : Number, min : int, max : int) : Number
		{
			if (value < min)
				value = min;
			
			else if (value > max)
				value = max;
			
			return value;
		}
	}
}