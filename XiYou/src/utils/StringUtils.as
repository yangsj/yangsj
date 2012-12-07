package utils
{


	public class StringUtils
	{
		public static function padingRight(val : *, num : uint, symbol : String) : String
		{
			var str : String = String(val);
			num = num - str.length;
			if (num <= 0)
				return str;
			else
				while (num--)
					str += symbol;
			return str;
		}
	}
}
